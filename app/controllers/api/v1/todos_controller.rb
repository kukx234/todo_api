class Api::V1::TodosController < ApplicationController
    before_action :set_user, only: [ :show, :update, :index ]
    before_action :set_todo_params, only: [ :create, :update ]
    def create
        todo = Todo.new(@todo_params)
        if todo.save
            render json: todo, status: :created
            return
        end
        render json: todo.errors, status: :unprocessable_entity
    rescue
        render json: { error: "Error creating todo" }, status: :not_found
    end

    def index
        render json: @user.todos
    rescue
        render json: { error: "Error fetching todos" }, status: :not_found
    end

    def show
        todo = @user.todos.find_by(id: params[:id]) || {}
        render json: todo, status: :ok
    rescue
        render json: { error: "Error fetching todos" }, status: :not_found
    end

     def update
        todo = @user.todos.find_by(id: params[:id])

        if todo.nil?
          render json: { error: "Todo is not found" }, status: :not_found
          return
        end

        if todo.update(@todo_params)
            render json: todo, status: :ok
            return
        end

        render json: todo.errors, status: :unprocessable_entity
    rescue
        render json: { error: "Error updating todos" }, status: :not_found
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_todo_params
      @todo_params = params.permit(*Todo::ALLOWED_PARAMS)
    end
end
