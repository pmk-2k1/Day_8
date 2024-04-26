class TodosController < ApplicationController
  def index
    @unfinished_tasks = current_user.todos.where(is_complete: false)
    render json: @unfinished_tasks
  end

  def task_complete
    @complete_tasks = current_user.todos.where(is_complete: true)
    render json: @complete_tasks
  end

  def show
    render json: @todo
  end

  def new
    @todo = current_user.todos.new
    render json: @todo
  end

  def create
    @todo = current_user.todos.new(todo_params)
    if @todo.save
      render json: @todo, status: :created, location: @todo
      redirect_to user_todos_path(current_user)
    else
      render json: @todo.errors, status: :unprocessable_entity
      redirect_to new_user_todo_path(current_user)
    end
  end

  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @todo.destroy
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :note, :time_start, :time_complete, :is_complete)
  end
end
