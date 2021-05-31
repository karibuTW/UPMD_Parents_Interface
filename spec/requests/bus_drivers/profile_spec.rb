require 'rails_helper'

RSpec.describe "BusDrivers::Profiles", type: :request do
  describe "GET /profile" do
    it "returns http success" do
      get "/bus_drivers/profile/profile"
      expect(response).to have_http_status(:success)
    end
  end

end
