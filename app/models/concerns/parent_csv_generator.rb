module ParentCsvGenerator
  extend ActiveSupport::Concern
  
  included do
    def csv
      csv_row = []
      csv_row << created_at
      csv_row << updated_at
      if new_bus_service?
        csv_row << "New"
      elsif renewed_bus_service?
        csv_row << "Renew"
      else
        csv_row << nil
      end
      csv_row << "Primary" if instance_of?(Parent)
      csv_row << "Secondary" if instance_of?(SecondaryParent)
      csv_row << first_name
      csv_row << last_name
      csv_row << full_name
      csv_row << preferred_language
      csv_row << email
      csv_row << phone_number
      csv_row << address

      children.limit(5).each do |child|
        csv_row << child.first_name
        csv_row << child.last_name
        csv_row << child.full_name
        csv_row << child.birth_date
        csv_row << ((Time.zone.now - child.birth_date.to_time) / 1.year.seconds).floor
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
