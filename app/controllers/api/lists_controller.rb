module Api
  class ListsController < ApplicationController
    def index
      render json: List.all
    end

    def show
      render json: List.find(params[:id])
    end

    def create
      list = List.create!(params[:list].permit(:name))

      PushNotification.publish "lists", "created", list.to_json

      render json: list
    end
  end
end