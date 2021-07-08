class BusDrivers::ProfileController < ApplicationController
  before_action :authenticate_bus_driver!

  def profile
    @q = Child.ransack(params[:q])
    @children = @q.result.includes(:parent).page(params[:page])
    csv_headers = ['Registration Date', 'Last Update', 'Bus', 'Renew?', 'ID',
                   'First Name', 'Last Name', 'Full Name', 'Date of Birth', 'Age', 'Unaccompanied?', 'Grade',
                   'Parent - First Name', 'Parent - Last Name', 'Parent - Full Name', 'Parent - Language',
                   'Parent - Email', 'Parent - Phone Number', 'Parent - Address',
                   '2nd Parent - First Name', '2nd Parent - Last Name', '2nd Parent - Full Name', '2nd Parent - Language',
                   '2nd Parent - Email', '2nd Parent - Phone Number', '2nd Parent - Address' ]
    respond_to do |format|
      format.html
      format.csv do
        rawcsv = CSV.generate(col_sep: ',') do |csv|
          # here you could add headers
          csv << csv_headers
          @children = @q.result.includes(:parent)
          @children.each do |child|
            csv << child.to_csv if child.taking_bus
          end
        end
        send_data rawcsv, filename: "children-#{Date.today}.csv"
      end
    end
  end

end
