require 'rails_helper'

RSpec.describe "Videos", type: :request do
  let(:user) { create(:user) }
  
  before do
    Rack::Attack.reset! if defined?(Rack::Attack)
    post user_session_path, params: { user: { email: user.email, password: "password123" } }
  end

  describe "GET /index" do
    it "returns http success" do
      get videos_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      skip "Need to create a video first"
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get new_video_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "redirects after create" do
      skip "Need to implement video creation logic"
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      skip "Need to create a video first"
    end
  end

  describe "PATCH /update" do
    it "redirects after update" do
      skip "Need to create a video first"
    end
  end

  describe "DELETE /destroy" do
    it "redirects after destroy" do
      skip "Need to create a video first"
    end
  end
end
