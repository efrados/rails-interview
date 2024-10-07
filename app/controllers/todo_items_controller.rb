# frozen_string_literal: true

class TodoItemsController < ApplicationController
  before_action :set_todo_item, only: %i[show edit update destroy complete]

  # GET /todo_items or /todo_items.json
  def index
    @todo_items = TodoItem.all
  end

  # GET /todo_items/1 or /todo_items/1.json
  def show; end

  # GET /todo_items/new
  def new
    @todo_item = TodoItem.new
  end

  # GET /todo_items/1/edit
  def edit; end

  # POST /todo_items or /todo_items.json
  def create
    @todo_item = TodoItem.new(todo_item_params)

    respond_to do |format|
      if @todo_item.save
        format.html do
          redirect_to todo_item_url(@todo_item), notice: 'Todo item was successfully created.'
        end
        format.json { render :show, status: :created, location: @todo_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todo_items/1 or /todo_items/1.json
  def update
    respond_to do |format|
      if @todo_item.update(todo_item_params)
        format.html do
          redirect_to todo_item_url(@todo_item), notice: 'Todo item was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @todo_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def complete
    if @todo_item.completed?
      render :show, status: :unprocessable_entity
    else
      @todo_item.completed!
      redirect_to todo_item_url(@todo_item), notice: 'Todo item was successfully completed.'
    end
  end

  # DELETE /todo_items/1 or /todo_items/1.json
  def destroy
    @todo_item.destroy

    respond_to do |format|
      format.html { redirect_to todo_items_url, notice: 'Todo item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_todo_item
    @todo_item = TodoItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def todo_item_params
    params.require(:todo_item).permit(:name, :status, :todo_list_id)
  end
end
