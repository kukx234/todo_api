class Api::V1::UsersController < ApplicationController
    def create
        user_params = params.permit(*User::ALLOWED_PARAMS)
        user = User.new(user_params)
        if user.save
            render json: user, status: :created
        else
            render json: user.errors, status: :unprocessable_entity
        end
    rescue
        render json: { error: "Error creating user" }, status: :not_found
    end

    def index
        render json: User.all
    end

    def show
        user = User.find(params[:id])
        render json: user, status: :ok
    rescue
        render json: { error: "Error fetching user" }, status: :not_found
    end

    def update
      user = User.find(params[:id])
      user_params = params.permit(*User::ALLOWED_PARAMS)
      if user.update(user_params)
         render json: user, status: :ok
         return
      end

      render json: user.errors, status: :unprocessable_entity
    rescue
        render json: { error: "Error updating user" }, status: :not_found
    end
end
