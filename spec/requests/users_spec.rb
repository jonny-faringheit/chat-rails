require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user, login: "testuser", email: "test@example.com", password: "password123") }

  describe "GET /:username" do
    context "when user is authenticated" do
      before do
        post user_session_path, params: { user: { email: user.email, password: "password123" } }
      end

      it "returns successful response" do
        get "/#{user.login}"
        expect(response).to have_http_status(:success)
      end

      it "displays user profile information" do
        get "/#{user.login}"
        expect(response.body).to include("@#{user.login}")
      end
    end

    context "when user is not authenticated" do
      it "redirects to sign in page" do
        get "/#{user.login}"
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user does not exist" do
      before do
        post user_session_path, params: { user: { email: user.email, password: "password123" } }
      end

      it "returns 404" do
        get "/nonexistentuser"
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
