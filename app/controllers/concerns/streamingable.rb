module Streamingable
  extend ActiveSupport::Concern

  included do
    include ActionController::Live
    before_action :set_http_headers, only: [:stream_data]
    expose :sse, -> { ActionController::Live::SSE.new(response.stream, event: 'message', retry: 3000) }

    private

    def set_http_headers
      http_headers = headers_object
      http_headers.each do |key, value|
        response.headers[key] = value
      end
    end

    def headers_object
      {
        'Content-Type' => 'text/event-stream',
        'Cache-Control' => 'no-cache',
        'Connection' => 'keep-alive'
      }
    end
  end
end
