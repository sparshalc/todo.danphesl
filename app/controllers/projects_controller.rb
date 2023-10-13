class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]
  before_action :verify_user, only: %i[ edit update destroy show ]
  def index
    @projects = current_user.projects.all.order('Created_at DESC')
  end

  def show
    @todos = current_user.todos.all.order('created_at DESC')
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
      params.require(:project).permit(:title, :user_id)
    end

    def verify_user
      @project = current_user.projects.find_by(id: params[:id])
      redirect_to root_path,alert: "Not Authorized!" if @project.nil?
    end
end
