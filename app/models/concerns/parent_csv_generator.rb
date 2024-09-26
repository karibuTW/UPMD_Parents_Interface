# frozen_string_literal: true

module ParentCsvGenerator
  extend ActiveSupport::Concern

  included do

    after_create_commit :send_info_to_moosend
    after_update_commit :update_info_to_moosend
    after_destroy :delete_user_from_moosend
  
    def delete_user_from_moosend
      if moosend_id.present?
        ::Moosend.delete_mail_in_mailing_list(moosend_id , parent_hash)
      end
    end
  
    def send_info_to_moosend
      response = ::Moosend.add_email_to_mailing_list(parent_hash)
      p response
      unless response["Error"].present?
        self.update_columns(moosend_id: response["Context"]["ID"])
      end
    end
  
    def update_info_to_moosend
      if moosend_id.present?
        ::Moosend.update_mail_in_mailing_list(moosend_id, parent_hash)
      end
    end
  
    def csv
      order = if instance_of?(Parent)
                current_year_helloasso_orders.first
              else
                parent.current_year_helloasso_orders.first
              end
      csv_row = []
      csv_row << created_at
      csv_row << updated_at
      csv_row << (order.present? ? order.helloasso_order_id : nil)
      csv_row << (paid_member? ? 'Yes' : 'No')
      csv_row << payment_date
      csv_row << (donated? ? 'Yes' : 'No')
      csv_row <<  if order.present?
                    (order.payment_method == 'Card' ? 'Credit Card' : 'Non Credit Card')
                  else
                    nil
                  end
      csv_row << if order.present?
                   (order.discount_code.present? ? order.discount_code.code : nil)
                 else
                   nil
                 end
      csv_row << if order.present?
                   (order.discount_code.present? ? order.discount_code.owner : 'HelloAsso')
                 else
                   nil
                 end
      csv_row << if order.present?
                   order.confirmation
                 else
                   nil
                 end
      csv_row << if new_bus_service?
                   'New'
                 elsif renewed_bus_service?
                   'Renew'
                 end
      csv_row << 'Primary' if instance_of?(Parent)
      csv_row << 'Secondary' if instance_of?(SecondaryParent)
      csv_row << first_name
      csv_row << last_name
      csv_row << full_name
      csv_row << preferred_language
      csv_row << email
      csv_row << phone_number
      csv_row << nationalities.filter{ |n| !n.blank? }.join(",")
      csv_row << address

      children.limit(5).each do |child|
        csv_row << child.first_name
        csv_row << child.last_name
        csv_row << child.full_name
        csv_row << child.birth_date
        csv_row << child.age
        csv_row << child.grade
      end
      if children.count < 5
        ((5 - children.count) * 6).times do
          csv_row << nil
        end
      end
      csv_row << children.count
    end

    def parent_hash
      if instance_of?(Parent)
        order = current_year_helloasso_orders.first
        parent_type = 'Primary'
        mailing_list_prime = mailing_list
      elsif instance_of?(SecondaryParent)
        mailing_list_prime = parent.mailing_list
        order = parent.current_year_helloasso_orders.first
        parent_type = 'Secondary'
      end

      bus_service = if new_bus_service?
                      'New'
                    elsif renewed_bus_service?
                      'Renew'
                    end
      
      code_used = if order.present?
                    (order.discount_code.present? ? order.discount_code.owner : 'HelloAsso')
                  else
                    nil
                  end
  
      payment_method =  if order.present?
                          (order.payment_method == 'Card' ? 'Credit Card' : 'Non Credit Card')
                        else
                          nil
                        end
      {
        Name: first_name + last_name,
        Email: email,
        CustomFields: [
          "Registration_Date=#{created_at}",
          "Last_Update=#{updated_at}",
          "firstname=#{first_name}",
          "lastname=#{last_name}",
          "fullname=#{full_name}",
          "parent_type=#{parent_type}",
          "Preferred_Language=#{preferred_language}",
          "Phone_number=#{phone_number}",
          "Address=#{address}",
          "Mailing_List=#{mailing_list_prime}",
          "Nationalities=#{nationalities.join(' ')}",
          
          "Paid=#{(paid_member? ? 'Yes' : 'No')}",
          
          "HelloAsso_ID=#{order.present? ? order.helloasso_order_id : nil}",
          "PaymentDate=#{payment_date}",
          "PaymentMethod=#{payment_method}",
          
          "Donated=#{(donated? ? 'Yes' : 'No')}",
          "CodeUsed=#{code_used}",
  
          "OrderConfirmation=#{order&.confirmation}",
          "Bus=#{bus_service}",
  
          "1st-Child-Full_name=#{children[0]&.full_name}",
          "1st-Child-Birth_date=#{children[0]&.birth_date}",
          "1st-Child-Age=#{children[0]&.age}",
          "1st-Child-Grade=#{children[0]&.grade}",
  
          "2nd-Child-Full_name=#{children[1]&.full_name}",
          "2nd-Child-Birth_date=#{children[1]&.birth_date}",
          "2nd-Child-Age=#{children[1]&.age}",
          "2nd-Child-Grade=#{children[1]&.grade}",
  
          "3rd-Child-Full_name=#{children[2]&.full_name}",
          "3rd-Child-Birth_date=#{children[2]&.birth_date}",
          "3rd-Child-Age=#{children[2]&.age}",
          "3rd-Child-Grade=#{children[2]&.grade}",
  
          "4th-Child-Full_name=#{children[3]&.full_name}",
          "4th-Child-Birth_date=#{children[3]&.birth_date}",
          "4th-Child-Age=#{children[3]&.age}",
          "4th-Child-Grade=#{children[3]&.grade}",
  
          "5th-Child-Full_name=#{children[4]&.full_name}",
          "5th-Child-Birth_date=#{children[4]&.birth_date}",
          "5th-Child-Age=#{children[4]&.age}",
          "5th-Child-Grade=#{children[4]&.grade}",
  
          "NumberOfChildren=#{children.count}"
        ]
      }
    end
  end
end
