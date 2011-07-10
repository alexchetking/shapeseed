class WorksController < ApplicationController
  before_filter :require_user, :except => [:show]
  
  def create
    @person = Person.find(params[:work][:person_id])
    @work = @person.works.build(params[:work])
    if @work.save
      flash[:success] = "Seed Added!"
      redirect_back_or_default @person
    else
      flash[:notice] = "Seed Submission Unsuccessful: Please check that the Name and Age fields are correct"
      redirect_back_or_default @person
    end
  end
  
  def destroy
    @work.destroy
    redirect_back_or_default root_path
  end
  
  def show
    @work = Work.find(params[:id])
    @user = User.find(@work.user_id)
    @title = "#{@user.first_name} #{@user.last_name}" 
  end
  
  private
    def authorized_user
      @work = Work.find(params[:id])
      redirect_to root_path unless current_user?(@work.user)
    end
end