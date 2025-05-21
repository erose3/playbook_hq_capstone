class TasksController < ApplicationController
  def index
    matching_tasks = Task.all

    @list_of_tasks = matching_tasks.order({ :created_at => :desc })

    render({ :template => "tasks/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_tasks = Task.where({ :id => the_id })

    @the_task = matching_tasks.at(0)

    render({ :template => "tasks/show" })
  end

  def create
    the_task = Task.new
    the_task.contract_id = params.fetch("query_contract_id")
    the_task.task_name = params.fetch("query_task_name")
    the_task.description = params.fetch("query_description")
    the_task.created_by = current_user.id
    the_task.deadline = params.fetch("query_deadline")
    the_task.completion_status = params.fetch("query_completion_status", false)
    the_task.completed_on = params.fetch("query_completed_on")
    the_task.assigned_to = params.fetch("query_assigned_to")

    if the_task.valid?
      the_task.save
      redirect_to("/contracts/#{the_task.contract_id}", { :notice => "Task created successfully." })
    else
      redirect_to("/contracts/#{the_task.contract_id}", { :alert => the_task.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_task = Task.where({ :id => the_id }).at(0)

    the_task.contract_id = params.fetch("query_contract_id")
    the_task.task_name = params.fetch("query_task_name")
    the_task.description = params.fetch("query_description")
    the_task.created_by = params.fetch("query_created_by")
    the_task.deadline = params.fetch("query_deadline")
    the_task.completion_status = params.fetch("query_completion_status", false)
    the_task.completed_on = params.fetch("query_completed_on")
    the_task.assigned_to = params.fetch("query_assigned_to")

    if the_task.valid?
      the_task.save
      redirect_to("/tasks/#{the_task.id}", { :notice => "Task updated successfully."} )
    else
      redirect_to("/tasks/#{the_task.id}", { :alert => the_task.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_task = Task.where({ :id => the_id }).at(0)

    the_task.destroy

    redirect_to("/tasks", { :notice => "Task deleted successfully."} )
  end
end
