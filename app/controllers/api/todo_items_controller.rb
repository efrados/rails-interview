module Api
  class TodoItemsController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :set_todo_item, except: :create

    # POST /api/todolists/todo_list_id/todo_items/
    def create
      @todo_item = todo_list.todo_items.create(name: params[:name])

      respond_to :json
    end

    # Funcionalidad de completar todos web sincronica con background job
# 3 operaciones desde la web agregar tests


    # PUT /api/todolists/todo_list_id/todo_items/id/complete
    def complete
      todo_item.completed!

      render json: todo_item
    end

    # DELETE /api/todolists/todo_list_id/todo_items/
    def destroy
      todo_item.destroy

      respond_to :json
    end

    private

    attr_reader :todo_item

    # TODO use permitted_attributes
    # def permitted_attributes
    #   params.require(:todo_items).permit(:name, :todo_list_id)
    # end

    def todo_list
      @todo_list ||= TodoList.find(params[:todo_list_id]) 
    end

    def set_todo_item
      @todo_item = todo_list.todo_items.find(params[:id])
    end
  end
end
