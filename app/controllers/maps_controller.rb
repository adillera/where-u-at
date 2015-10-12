class MapsController < ApplicationController
  include ActionController::Live
  def show
  end

  def publish
    data = {
      lat_lng: params[:latLng],
      handle: params[:handle]
    }

    redis = Redis.new
    redis.publish params[:channel], data.to_json

    render nothing: true
  end

  def feed
    begin
      response.headers['Content-Type'] = 'text/event-stream'

      redis = Redis.new
      sse = SSE.new(response.stream)

      redis.subscribe(params[:channel]) do |on|
        on.message do |channel, message|
          sse.write(message)
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
