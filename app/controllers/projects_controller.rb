class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
    @project_new = Project.new
  end

  def create
    @users = User.all
    @project = Project.create(project_params)
    assign_users
    if @project.save!
      redirect_to @project
    end
  end

  def show
    @projects = Project.all
    @project = Project.find(params[:id])
    @tasks = @project.tasks.all
    @users = User.all
    @department = @project.department
    @team = @project.users
  end

  def edit
    @project = Project.find(params[:id])
    @department = @project.department
    @users = User.all
  end

  def update
    @project = Project.find(params[:id])
    @project.update(project_params)
    @project.users.destroy_all
    @team = @project.users
    user_ids = params[:project][:user_ids]
    user_ids.each do |user_id|
      if !user_id.blank?
        @project.users << User.find(user_id)
      else
      end
    end
    redirect_to @project
  end

  def destroy
    respond_to do |format|
      @project = Project.find(params[:id]).destroy
      format.js
      format.html{redirect_to departments_path}
    end
  end

  private

  def assign_users
    user_ids = params[:project][:user_ids]
    user_ids.each do |user_id|
      if !user_id.blank? 
        @project.users << User.find(user_id)
      else
      end
    end
  end

  def project_params
    params.require(:project).permit(:department_id, :name, :description, :deadline, :id, :user_ids)
  end

end
