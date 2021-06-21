require 'rails_helper'

RSpec.describe 'BusDrivers::Children', type: :request do
  describe 'GET /show' do
    it 'should authenticate bus driver' do
      get '/bus_drivers/children/show'
      expect(response).to have_http_status(:found)
    end

    it 'returns http success' do
      @user = create(:bus_driver)
      @bus_service = create(:bus_service)
      @child = create(:child, parent: @bus_service.parent)
      @user.confirm
      sign_in @user
      get bus_drivers_child_path(id: @child.id)
      expect(response).to have_http_status(:success)
    end
  end

end
