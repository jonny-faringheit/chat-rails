require Rails.root.join("lib/rack_attack/throttles.rb")

RackAttack::Throttles.load

Rack::Attack.throttled_responder = lambda do |request|
  match_data = request.env['rack.attack.match_data'] || {}
  retry_after = match_data[:period]
  [
    429,
    { 'Content-Type' => 'application/json', 'Retry-After' => retry_after.to_s },
    [
      {
        error: "Too many requests. Please try again later.",
        limit: match_data[:limit],
        count: match_data[:count],
        retry_after: retry_after
      }.to_json
    ]
  ]
end
