class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
end
