module Api
  class ListsController < ApplicationController
    def index
      render json: List.all
    end

    def show
      render json: List.first
    end
  end
end