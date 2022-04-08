# frozen_string_literal: true

class TasksController < UserBaseController
  before_action :find_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.page(page_param).per(per_page_param)
  end

  def show; end

  def new
    @task = current_user.tasks.build
  end

  def edit; end

  def create
    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html do
          redirect_to task_url(@task), notice: I18n.t('common.create_success_message', model: Task.model_name.human)
        end
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html do
          redirect_to task_url(@task), notice: I18n.t('common.update_success_message', model: Task.model_name.human)
        end
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy

    respond_to do |format|
      format.html do
        redirect_to tasks_url, notice: I18n.t('common.destroy_success_message', model: Task.model_name.human),
                               status: :see_other
      end
      format.json { head :no_content }
    end
  end

  private

  def find_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :done)
  end
end
