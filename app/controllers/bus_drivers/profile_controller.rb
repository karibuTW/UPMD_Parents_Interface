class BusDrivers::ProfileController < ApplicationController
  before_action :authenticate_bus_driver!

  def profile
    @q = Child.ransack(params[:q])
    @children = @q.result.includes(:parent).page(params[:page])
    csv_headers = ['ID SBS', 'SBS Balance',	'Scholarship',	'Mask/Card',	'Remarq Past',	'Date meeting',
                   'Contrat', 'Paid new year',	'HelloAsso/Form',	'HelloAsso ID',	'Paid?',	'Prev ID',	'Renew?',	'ID',
                   'QR Code',	'First Name',	'Last Name',	'Full Name',	'Date of Birth',	'Age',	'Unaccompanied?',
                   'Grade Level',	'Grade Name',	'Class Name',	'Note',	'MON',	'TUE',	'WED',	'THU',	'FRI',	'A MON',
                   'A TUE',	'A WED',	'A THU',	'A FRI', 'B MON', 'B TUE',	'B WED',	'B THU',	'B FRI',	'ID',	'QR Code',
                   'First Name',	'Last Name',	'Full Name',	'Language',	'Email Address',	'Phone Number',	'Address',
                   'ID',	'QR Code',	'First Name',	'Last Name',	'Full Name',	'Language',	'Email Address',
                   'Phone Number',	'Address',	'Pick Up',	'Drop Off'
    ]
    respond_to do |format|
      format.html
      format.csv do
        rawcsv = CSV.generate(col_sep: ',') do |csv|
          # here you could add headers
          csv << csv_headers
          @children = @q.result.includes(:parent)
          @children.each do |child|
            csv << child.to_bus_csv if child.taking_bus?
          end
        end
        send_data rawcsv, filename: "children-#{Date.today}.csv"
      end
    end
  end

end
