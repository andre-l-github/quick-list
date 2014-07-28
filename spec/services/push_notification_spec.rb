require "spec_helper"

describe PushNotification do
  let(:redis_stub) { RedisPubSubStub.new }
  before { Redis.stub :new => redis_stub }

  it "publishes and subscribes to channels" do
    proc = Proc.new do |b|
      PushNotification.listen("aChannel", &b)
      PushNotification.publish "aChannel", "anEvent", { "content" => "theContent" }
    end

    expect(proc).to yield_with_args("anEvent", { "content" => "theContent" })
  end

end