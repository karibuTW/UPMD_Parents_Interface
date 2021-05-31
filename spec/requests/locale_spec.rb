require 'rails_helper'

RSpec.describe "Locales", type: :request do
  describe "GET /choose_locale" do
    it "returns http success" do
      get "/locale/choose_locale"
      expect(response).to have_http_status(:success)
    end
  end

end
