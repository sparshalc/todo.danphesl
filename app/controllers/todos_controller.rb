class TodosController < ApplicationController
  before_action :set_project
  before_action :set_todos, only: [:edit, :update, :destroy]
    def new
      @todo = @project.todos.build
    end
  
    def edit
    end
    
    def show
      @todo = current_user.todos.find(params[:id])
    end
    
  
    def update
      if @todo.update(todo_params)
        respond_to do |format|
          format.html { redirect_to root_path, notice: "Todo was successfully updated." }
          format.turbo_stream { flash.now[:notice] = "Todo was successfully updated." }
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def create
      @todos = @project.todos.all
      @todo = @project.todos.build(todo_params)
  
      if @todo.save
        respond_to do |format|
          format.html { redirect_to root_path, notice: "Todo was successfully created." }
          format.turbo_stream { flash.now[:notice] = "Todo was successfully created." }
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      @todo.destroy
      @todos = @project.todos.all
    
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Todo was successfully destroyed." }
        format.turbo_stream { flash.now[:notice] = "Todo was successfully destroyed." }
      end
    end

    def complete

      @todo = @project.todos.find(params[:id])
      @todos = @project.todos.all
  
      if @todo.update(completed_at: Time.now)
        respond_to do |format|
          format.turbo_stream { flash.now[:notice] = "Todo marked as completed!"}
          format.html { redirect_to project_path(@project) }
        end
      else
      end
    end
    
    private
  
    def todo_params
      params.require(:todo).permit(:title, :description, :user_id)
    end
  
    def set_todos
      @todo = @project.todos.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end
end