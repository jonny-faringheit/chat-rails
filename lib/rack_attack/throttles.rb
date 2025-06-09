module RackAttack
  module Throttles
    def self.load
      Rack::Attack.throttle('signin/ip', limit: 5, period: 60) do |req|
        req.ip if req.path.include?('/users/signin') && req.post?
      end

      Rack::Attack.throttle('signup/ip', limit: 1, period: 5) do |req|
        req.ip if req.path.include?('/users/signup') && req.post?
      end
    end
  end
end
