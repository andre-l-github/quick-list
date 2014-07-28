class PushNotification
  attr_reader :redis, :channel

  def initialize(redis, channel)
    @redis   = redis
    @channel = channel
  end

  def publish(event, data)
    redis.publish channel, {
      event: event,
      data:  data
    }.to_json
  end

  def listen(&block)
    redis.subscribe([channel]) do |on|
      on.message do |chn, msg|
        JSON.parse(msg).tap do |payload|
          yield payload["event"], payload["data"]
        end
      end
    end
  end

  def self.publish(channel, event, data)
    PushNotification.new(redis, channel).publish(event, data)
  end

  def self.listen(channel, &block)
    PushNotification.new(redis, channel).listen(&block)
  end

  def self.redis
    Redis.new(:timeout => 1)
  end
end
