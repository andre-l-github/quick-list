module Api
  class NotificationsController < ApplicationController
    include ActionController::Live

    def show
      response.headers['Content-Type'] = 'text/event-stream'
      sse = SSE.new(response.stream)

      PushNotification.listen params[:id] do |event, data|
        sse.write(data, event: event)
      end

    ensure
      sse.close
    end

  end
end