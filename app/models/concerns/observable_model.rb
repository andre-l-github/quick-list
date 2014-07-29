module ObservableModel

  def self.included(base)
    base.include InstanceMethods

    base.after_create  { |record| record._push_notification("created")   }
    base.after_destroy { |record| record._push_notification("destroyed") }
  end

  module InstanceMethods
    def _push_notification(event)
      self.class.active_model_serializer.new(self).as_json.tap do |serialized|
        PushNotification.publish self.class.name.underscore, event, serialized
      end
    end
  end

end