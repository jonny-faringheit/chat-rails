class StreamsController < ApplicationController
  include Streamingable
  before_action :authenticate_user!

  def stream_data
    begin
      10.times do |i|
        sse.write({ message: "Hello World #{i}" }, event: 'message')
        sleep 1
      end
    rescue ActionController::Live::ClientDisconnected => e
      Rails.logger.info "Client disconnected: #{e.message}"
    ensure
      sse.close
    end
  end
end
