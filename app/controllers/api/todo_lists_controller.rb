# frozen_string_literal: true

module API
  class TodoListsController < API::ApplicationController
    # GET /api/todolists
    def index
      @todo_lists = TodoList.all

      render json: @todo_lists
    end
  end
end
