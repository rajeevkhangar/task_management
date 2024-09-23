class TasksController < ApplicationController
  before_action :authorize_request

  before_action :authorise_user_access

  def complete
    begin
      task = @current_user.tasks.find params[:task_id]
      unless task.completed?
        task.update(completed: true)
        return render json: task, status: :ok
      end

      render json: { error: 'Already completed' }, status: 200
    rescue Exception => e
      record_not_found
    end
  end

  def assigned
    render json: @current_user.tasks, status: :ok
  end

  def create
    render json: @current_user.created_tasks.create(task_params), status: 201
  end

  def assign
    begin
      task = Task.find(params[:task_id])

      task_assignment = task.task_assignments.where(user_id: params[:user_id]).first_or_initialize do |t|
        t.assigned_by = @current_user.id
        t.save
      end

      render json: task_assignment, status: 201

    rescue Exception => e
      record_not_found
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description)
  end
end
