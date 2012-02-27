#!/usr/bin/env ruby -I ../lib -I lib
# coding: utf-8
require 'libs/db_setup'
require 'sinatra'
require 'libs/partials'

helpers Sinatra::Partials
set :server, 'thin'
enable :sessions

before do
	logger.info "in global"
	@successes = {} #Success Alerts
	@errors = {} #Error Alerts
	@infos = {} #Info Alerts
	@values = {} #Form Values
	
	if session[:values]
		@values = session[:values]
		session[:values] = nil
	end
	if session[:messages]
		@errors = session[:messages]
		session[:messages] = nil
	end
	if session[:errors]
		@errors = session[:errors]
		session[:errors] = nil
	end
end

require 'sessions';
require 'clients'
require 'projects'
require 'invoices'
require 'helpers'



get '/' do
#  erb :index, :locals => { :user => session[:user].gsub(/\W/, '') }
  erb :index
end
