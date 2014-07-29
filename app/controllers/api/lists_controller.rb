module Api
  class ListsController < ApplicationController

    def index
      render json: List.all
    end

    def show
      render json: resource
    end

    def create
      render json: List.create!(params[:list].permit(:name))
    end

    def destroy
      resource.destroy

      render json: resource
    end

  private

    def serialize(res)
      ListSerializer.new(res).as_json
    end

    def resource
      @resource ||= List.find(params[:id])
    end
  end
end
