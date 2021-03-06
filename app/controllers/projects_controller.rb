class ProjectsController < ApplicationController
  before_filter :login_required
  before_filter :validate_ownership, :except => [:index, :new, :create]

  # GET /projects
  # GET /projects.json
  def index
    @projects = @current_user.projects

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, :notice => 'Project was successfully created.' }
        format.json { render :json => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.json { render :json => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find_by_id(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, :notice => 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find_by_id(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  # POST /projecst/1/generate
  def generate
    @project = Project.find_by_id(params[:id])
    if params[:log].nil? || params[:log].length == 0
      respond_to do |format|
        format.html { redirect_to :back, :notice => 'No task logs were selected.' }
        format.json { head :no_content }
      end
    else
      tasks = Hash.new
      params[:log].each do |logid|
        log = Log.find_by_id(logid)
        unless tasks.has_key?(log.task.id)
          tasks[log.task.id] = {
            'name' => log.task.name,
            'description' => log.task.description,
            'total' => 0
          }
        end
        tasks[log.task.id]['total'] += log.billable
        log.invoiced = true
        log.save
      end
      invoice = Invoice.new
      invoice.project = @project
      invoice.date = Time.now
      tasks.each do |task_id,task|
        invoice_entry = InvoiceEntry.new
        invoice_entry.title = task['name']
        invoice_entry.description = task['description']
        invoice_entry.hours = task['total']
        invoice_entry.rate = @project.rate
        invoice_entry.save
        invoice.invoice_entries.push invoice_entry
      end
      invoice.save
      respond_to do |format|
        format.html { redirect_to project_invoices_url(@project), :notice => 'Invoice created!' }
        format.json { head :no_content }
      end
    end
  end

  private

  def validate_ownership
    project = Project.find_by_id(params[:id])
    if project.client.user != @current_user 
      respond_to do |format|
        format.html { redirect_to projects_path, :notice => "Sorry, you don't have access to that project." }
        format.json { render :status => 403 }
      end
    end
  end

end
