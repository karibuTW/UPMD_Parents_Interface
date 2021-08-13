# frozen_string_literal: true

module ParentCsvGenerator
  extend ActiveSupport::Concern

  included do
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
  end
end
