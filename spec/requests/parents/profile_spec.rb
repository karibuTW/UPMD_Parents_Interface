require 'rails_helper'

RSpec.describe "Parents::Profiles", type: :request do
  describe "GET /parents" do
    it 'should authenticate parent' do
      get '/parents'
      expect(response).to have_http_status(:found)
    end

    it "returns http success" do
      @user = create(:parent, phone_number: '+911234567890')
      @user.confirm
      sign_in @user
      get "/parents"
      expect(response).to have_http_status(:success)
    end
  end

end
