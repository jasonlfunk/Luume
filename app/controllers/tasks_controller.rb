class TasksController < ApplicationController
  before_filter :login_required

  def index
    @project = Project.find(params[:project_id])
    if @project.nil? || @project.client.user != current_user
      respond_to do |format|
        format.html { redirect_to projects_path, :notice => "Sorry, you don't have access to that project." }
        format.json { render :status => 404 }
      end
    end
    @tasks = @project.tasks
    respond_to do |format|
        format.html 
        format.json { render :status => 200, :json=>@tasks }
    end
  end
  
  def new
    @project = Project.find(params[:project_id])
    if @project.nil? || @project.client.user != current_user
      respond_to do |format|
        format.html { redirect_to projects_path, :notice => "Sorry, you don't have access to that project." }
        format.json { render :status => 404 }
      end
    end
    @task = Task.new
    @task.project = @project
  end

  # GET /tasks/1/edit
  def edit
    @project = Project.find(params[:project_id])
    if @project.nil? || @project.client.user != current_user
      respond_to do |format|
        format.html { redirect_to projects_path, :notice => "Sorry, you don't have access to that project." }
        format.json { render :status => 404 }
      end
    end
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @project = Project.find(params[:project_id])
    if @project.nil? || @project.client.user != current_user
      respond_to do |format|
        format.html { redirect_to projects_path, :notice => "Sorry, you don't have access to that project." }
        format.json { render :status => 404 }
      end
    end
    @task = Task.new(params[:task])
    @task.project = @project

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_tasks_path(@project), :notice => 'Task was successfully created.' }
        format.json { render :json => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.json { render :json => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @project = Project.find(params[:project_id])
    if @project.nil? || @project.client.user != current_user
      respond_to do |format|
        format.html { redirect_to projects_path, :notice => "Sorry, you don't have access to that project." }
        format.json { render :status => 404 }
      end
    end
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to project_tasks_path(@project), :notice => 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @project = Project.find(params[:project_id])
    if @project.nil? || @project.client.user != current_user
      respond_to do |format|
        format.html { redirect_to projects_path, :notice => "Sorry, you don't have access to that project." }
        format.json { render :status => 404 }
      end
    end
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to project_tasks_url(@project), :notice => "Task was successfully deleted." }
      format.json { head :no_content }
    end
  end
end
