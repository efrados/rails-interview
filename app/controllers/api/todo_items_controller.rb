# frozen_string_literal: true

module API
  class TodoItemsController < API::ApplicationController
    before_action :set_todo_item, except: :create

    def create
      @todo_item = TodoItem.new(resource_params)

      render json: @todo_item.errors, status: :unprocessable_entity unless @todo_item.save
    end

    # PUT /api/todolists/todo_list_id/todo_items/id/complete
    def complete
      todo_item.completed!

      render json: todo_item
    end

    # DELETE /api/todolists/todo_list_id/todo_items/
    def destroy
      todo_item.destroy

      render json: todo_item
    end

    private

    attr_reader :todo_item

    def resource_params
      params.permit(:id, :name, :todo_list_id)
    end

    def set_todo_item
      @todo_item = TodoItem.find(resource_params[:id])
    end
  end
end
