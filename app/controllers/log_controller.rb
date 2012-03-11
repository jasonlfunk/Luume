class LogController < ApplicationController
  before_filter :login_required
end
