class LogController < ApplicationController
  before_filter :login_required
  before_filter :validate_ownership, :except => [:start, :stop]
  
  def start
    @log = Log.new
    @log.task = Task.find(params[:task_id])
    if @log.task.project.client.user != @current_user 
      respond_to do |format|
        format.html { redirect_to project_tasks_path(@log.task.project), :notice => "Starting log failed" }
        format.json { render :json => @log.errors, :status => :unprocessable_entity }
      end
    else
      if @log.task.running?
        respond_to do |format|
          format.html { redirect_to project_tasks_path(@log.task.project), :notice => "Starting log failed" }
          format.json { render :json => @log.errors, :status => :unprocessable_entity }
        end
      else
        @log.start = DateTime.now

        respond_to do |format|
          if @log.save
            format.html { redirect_to project_tasks_path(@log.task.project) }
            format.json { render :json => @log }
          else
            format.html { redirect_to project_tasks_path(@log.task.project), :notice => "Starting log failed" }
            format.json { render :json => @log.errors, :status => :unprocessable_entity }
          end
        end
      end
    end
  end

  def stop
    task = Task.find(params[:task_id])
    @log = task.logs.find(:all, :conditions => { :end => nil }).first
    if @log.task.project.client.user != @current_user 
      respond_to do |format|
        format.html { redirect_to project_tasks_path(@log.task.project), :notice => "Starting log failed" }
        format.json { render :json => @log.errors, :status => :unprocessable_entity }
      end
    else
      @log.end = DateTime.now
      respond_to do |format|
        if @log.save
          format.html { redirect_to project_tasks_path(@log.task.project) }
          format.json { render :json => @log }
        else
          format.html { redirect_to project_tasks_path(@log.task.project), :notice => "Stopping log failed" }
          format.json { render :json => @log.errors, :status => :unprocessable_entity }
        end
      end
    end
  end
  
  def destroy
    @log = Log.find(params[:id])
    @log.destroy

    respond_to do |format|
      format.html { redirect_to project_tasks_path(@log.task.project)}
      format.json { head :no_content }
    end
  end
  
  def update
    @log = Log.find(params[:id])

    respond_to do |format|
      if @log.update_attributes({:actual => params[:actual], :billable => params[:billable]})
        format.json { render :status => 200, :json => {:success => 1} }
      else
        format.json { render :status => :unprocessable_entity, :json => @log.errors }
      end
    end
  end
  
  private

  def validate_ownership
    log = Log.find(params[:id] || params[:log_id])
    if log.task.project.client.user != @current_user 
      respond_to do |format|
        format.html { redirect_to projects_path, :notice => "Sorry, you don't have access to that project." }
        format.json { render :status => 403 }
      end
    end
  end
end
