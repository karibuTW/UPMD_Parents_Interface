require 'rails_helper'

RSpec.describe "BusDrivers::Profiles", type: :request do
  describe "GET /profile" do
    it 'should authenticate bus driver' do
      get '/bus_drivers'
      expect(response).to have_http_status(:found)
    end

    it "returns http success" do
      @user = create(:bus_driver)
      @user.confirm
      sign_in @user
      get "/bus_drivers"
      expect(response).to have_http_status(:success)
    end
  end

end
