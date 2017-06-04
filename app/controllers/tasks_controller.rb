class TasksController < ApplicationController
  before_action :all_tasks, only: [:index, :create]
  before_action :set_tasks, only: [:edit, :update]

  respond_to :html, :js

  def index
     respond_to do |format|
       format.html
       format.json
     end
   end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:notice] = 'Task created'
      redirect_to @task
    else
      flash[:alert] = 'Task not created'
      render :new
    end
  end

  def update
    if @task.update_attributes(task_params)
      flash[:notice] = 'Task updated'
      redirect_to @task
    else
      flash[:alert] = 'Task not updated'
      render :edit
    end      
  end

  def destroy
    @task.destroy
    flash[:notice] = 'Task deleted'
    redirect_to @task
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def all_tasks
      @tasks = Task.all
    end

    def task_params
      params.require(:task).permit(:description, :deadline)
    end
end
