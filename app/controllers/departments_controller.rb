class DepartmentsController < ApplicationController
  def index
  end

  def show
    @department = Department.find(params[:id])
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.create(department_params)
    redirect_to @department
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def department_params
    params.require(:department).permit(:name)
  end
end
