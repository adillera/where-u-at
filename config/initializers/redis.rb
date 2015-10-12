require "redis"

$redis = Redis.new

# Heartbeat
# This makes sure that threads are still active.
heartbeat_thread = Thread.new do
  while true
    $redis.publish('heartbeat', 'thump')
    sleep 10.seconds
  end
end

at_exit do
  heartbeat_thread.kill

  $redis.quit
end
