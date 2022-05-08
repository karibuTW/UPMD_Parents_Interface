class MoosendJob < ApplicationJob
    queue_as :default

    def perform()
      add_exisiting_parents_to_mossend
      add_exisiting_scondary_parents_to_mossend
    end

    def add_exisiting_parents_to_mossend
      Parent.all.each do |parent|
        unless parent.moosend_id.present?
          response = ::Moosend.add_email_to_mailing_list(parent.parent_hash)
          unless response["Error"].present?
            parent.update!(moosend_id: response["Context"]["ID"])
          end
        end
      end
      nil
    end

    def add_exisiting_scondary_parents_to_mossend
      SecondaryParent.all.each do |parent|
        unless parent.moosend_id.present?
          response = ::Moosend.add_email_to_mailing_list(parent.parent_hash)
          unless response["Error"].present?
            parent.update!(moosend_id: response["Context"]["ID"])
          end
        end
      end
      nil
    end
end
  