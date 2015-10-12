class MapsController < ApplicationController
  include ActionController::Live
  def show
  end

  def feed
    begin
      response.headers['Content-Type'] = 'text/event-stream'

      redis = Redis.new
      sse = SSE.new(response.stream)

      redis.subscribe('testChannel') do |on|
        on.message do |channel, message|
          sse.write({ data: message, event: 'message' })
        end
      end
    rescue IOError, ActionController::Live::ClientDisconnected
      logger.info 'Stream closed'
    ensure
      redis.quit

      sse.close
    end

    render nothing: true
  end
end
