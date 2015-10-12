class MapsController < ApplicationController
  include ActionController::Live
  def show
  end

  def feed
    begin
      response.headers['Content-Type'] = 'text/event-stream'
      sse = SSE.new(response.stream)

      $redis.subscribe('testChannel', 'heartbeat') do |on|
        on.message do |channel, message|
          sse.write({ data: message, event: 'message' })
        end
      end
    rescue IOError
      logger.info 'Stream closed'
    ensure
      sse.close
    end

    render nothing: true
  end
end
