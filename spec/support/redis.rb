class RedisPubSubStub

  attr_reader :subscriptions

  def initialize
    @subscriptions = {}
  end

  def publish(channel, data)
    subscriptions.fetch(channel, []).each do |subscription|
      subscription.notify(channel, data)
    end
  end

  def subscribe(channels, &block)
    channels.each do |channel|
      subscriptions[channel] ||= []
      subscription = Subscription.new

      yield subscription

      subscriptions[channel] << subscription
    end
  end

  class Subscription
    attr_reader :proc

    def notify(channel, msg)
      proc.call channel, msg
    end

    def message(&block)
      @proc = Proc.new do |chn, data|
        yield chn, data
      end
    end
  end
end
