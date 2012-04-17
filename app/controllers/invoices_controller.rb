class InvoicesController < ApplicationController
  before_filter :login_required

  def index
    @project = Project.find(params[:project_id])
    if @project.nil? || @project.client.user != current_user
      respond_to do |format|
        format.html { redirect_to projects_path, :notice => "Sorry, you don't have access to that project." }
        format.json { render :status => 404 }
      end
    end
    @invoices = @project.invoices
  end
  def show
    @invoice = Invoice.find(params[:id])
    if @invoice.nil? || @invoice.project.client.user != current_user
      respond_to do |format|
        format.html { redirect_to projects_path, :notice => "Sorry, you don't have access to that project." }
        format.json { render :status => 404 }
      end
    end
  end
  def destroy
    @invoice = Invoice.find(params[:id])
    if @invoice.nil? || @invoice.project.client.user != current_user
      respond_to do |format|
        format.html { redirect_to projects_path, :notice => "Sorry, you don't have access to that project." }
        format.json { render :status => 404 }
      end
    end
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to :back, :notice => "Invoice deleted." }
      format.json { render :status => 200 }
    end
  end
end
