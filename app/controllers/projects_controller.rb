class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy assign_user ]
  before_action :verify_user, only: %i[ edit update destroy show ]
  def index
    @projects = current_user.projects.all.order('Created_at DESC')
  end

  def show
    @todos = @project.todos.all.order('Created_at DESC')
    @users = User.where.not(id: current_user.id)
  end

  def assigned
    @projects = Project.where(assigned_by: current_user.id, assigned_status: true).order(created_at: :desc)
  end

  def assign_user
    selected_user_id = params[:selected_user]
    selected_user_email = User.find(selected_user_id).email
    if @project.update(user_id: selected_user_id, assigned_status: true)
      flash[:success] = "Project assigned to the #{selected_user_email.split('@')[0].capitalize! }"
    else
      flash[:error] = "Failed to assign the project to the selected user."
    end
    redirect_to root_path
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.turbo_stream { flash.now[:notice] = "Project was successfully created." }
        format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.turbo_stream { flash.now[:notice] = "Project was successfully updated." }
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy!

    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = "Project was successfully destroyed." }
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
    end
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:title, :user_id, :assigned_by, :assigned_status)
    end

    def verify_user
      @project = current_user.projects.find_by(id: params[:id])
      redirect_to root_path,alert: "Not Authorized!" if @project.nil?
    end
end
