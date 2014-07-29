module Api
  class ListsController < ApplicationController

    def index
      render json: List.all
    end

    def show
      render json: resource
    end

    def create
      list = List.create!(params[:list].permit(:name))

      PushNotification.publish "lists", "created", list.to_json

      render json: list
    end

    def destroy
      resource.destroy

      render json: resource
    end

  private

    def resource
      @resource ||= List.find(params[:id])
    end
  end
end