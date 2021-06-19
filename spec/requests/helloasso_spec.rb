require 'rails_helper'

RSpec.describe "Helloassos", type: :request do
  describe "GET /webhook" do
    it "returns http success" do
      post "/helloasso/webhook"
      expect(response).to have_http_status(:success)
    end
  end

end
