require 'rails_helper'

RSpec.describe "Rate limiting with Rack::Attack", type: :request do
  before do
    Rack::Attack.enabled = true
    Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new
    Rack::Attack.reset!
  end

  after do
    Rack::Attack.reset!
  end

  let(:ip) { "1.2.3.4" }

  it "limits sign in requests by IP address" do
    valid_params = { user: { email: "test@example.com", password: "password" } }
    
    5.times do
      post "/users/signin", params: valid_params, headers: { "REMOTE_ADDR" => ip }
      expect(response).to have_http_status(:ok).or have_http_status(:unprocessable_entity)
    end

    post "/users/signin", params: valid_params, headers: { "REMOTE_ADDR" => ip }
    expect(response).to have_http_status(:too_many_requests)
  end

  it "limits sign up requests by IP address" do
    2.times do |i|
      valid_params = { user: { email: "test#{i}@example.com", password: "password123" } }
      post "/users/signup", params: valid_params, headers: { "REMOTE_ADDR" => ip }
    end
    
    expect(response).to have_http_status(:too_many_requests)
  end
end
