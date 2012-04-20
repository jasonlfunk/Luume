class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      respond_to do |format|
        format.html { redirect_to_target_or_default root_url, :notice => "Logged in successfully." }
        format.json { render :status => 200, :json => { :user => user } }
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:error] = "Invalid login or password."
          render :action => 'new'
        end
        format.json do
          render :status => 403, :json => {}
        end
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "You have been logged out."
  end
end
