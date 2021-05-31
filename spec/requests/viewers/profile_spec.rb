require 'rails_helper'

RSpec.describe "Viewers::Profiles", type: :request do
  describe "GET /profile" do
    it "returns http success" do
      get "/viewers/profile/profile"
      expect(response).to have_http_status(:success)
    end
  end

end
