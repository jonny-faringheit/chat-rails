require 'rails_helper'

RSpec.describe "Musics", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/musics/index"
      expect(response).to have_http_status(:success)
    end
  end

end
