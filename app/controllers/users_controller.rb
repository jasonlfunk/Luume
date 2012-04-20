class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Thank you for signing up! You are now logged in."
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end

  # Gets whether the user is currently being timed
  def status
    found_task = nil
    current_user.projects.each do |project|
      log = Log.find(:all, :conditions => { :task_id => project.tasks, :end => nil }).first
      if log 
          found_task = log.task
          break
      end
    end
    respond_to do |format|
      if found_task
        format.json { render :status => 200, :json => {:status => found_task, :timer => found_task.actual} }
      else
        format.json { render :status => 200, :json => {:status => nil} }
      end
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to profile_url, :notice => "Your profile has been updated."
    else
      render :action => 'edit'
    end
  end
end
