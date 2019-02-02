class TasksController < ApplicationController
  def index
    # タスクを日時が最新で表示
    @tasks = current_user.tasks.order(created_at: :desc)
  end

  def show
    @task = current_user.task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    # mergeメソッドでTaskオブジェクトに対してcurrent_userのuser_idを統合する
    # @task = Task.new(task_params.merge(user_id: current_user.id))
    # current_userに対してリレーションによるメソッドを利用してtaskオブジェクトを作成
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to tasks_url, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    @task = current_user.task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.name}」を更新しました。"
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.name}」を削除しました。"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
