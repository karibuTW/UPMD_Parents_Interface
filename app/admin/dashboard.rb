ActiveAdmin.register_page "Dashboard" do
  menu priority: 10
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }
  # Numbers of family + Numbers of bus registration for the year + Numbers of payment by credit card (No discount code)
  # + Numbers of children + Numbers of people having donated
  content title: proc { I18n.t("active_admin.dashboard") } do
    panel "Stats" do
      div do
        span "Number of families: #{Parent.count}"
      end
      div do
        span "Number of bus registrations (#{Setting.current_school_year_start} - #{Setting.current_school_year_end}): #{BusService.where(year: Setting.current_school_year_start).count}"
      end

      div do
        span "Number of payment by credit card (No discount code): #{HelloassoOrder.where(discount_code_id: nil).count}"
      end

      div do
        span "Number of children: #{Child.count}"
      end

      div do
        span "Number of donors: #{HelloassoOrder.where("amount_total > 1110").count}"
      end
    end
  end
end
