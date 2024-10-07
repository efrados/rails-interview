# frozen_string_literal: true

class TodoListsController < ApplicationController
  before_action :set_todo_list, only: %i[complete]

  # GET /todolists
  def index
    @todo_lists = TodoList.all

    respond_to :html
  end
  
  # GET /todolists/new
  def new
    @todo_list = TodoList.new
    
    respond_to :html
  end

  def complete
    complete_list

    redirect_to @todo_list, notice: 'Todo list is going to be completed shortly'
  end

  private

  def set_todo_list
    @todo_list = TodoItem.find(params[:id])
  end

  def complete_list
    CompleteTodoListJob.perform_later(@todo_list.id)
  end
end
