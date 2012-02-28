#!/usr/bin/env ruby -I ../lib -I lib
# coding: utf-8
require 'libs/db_setup'
require 'sinatra'
require 'libs/partials'
require 'json/pure'

helpers Sinatra::Partials
set :server, 'thin'
enable :sessions

before do
	@successes = {} #Success Alerts
	@errors = {} #Error Alerts
	@infos = {} #Info Alerts
	@values = {} #Form Values
	
	if session[:values]
		@values = JSON.parse(session[:values],:symbolize_names => true)
		session[:values] = nil
	end
	if session[:successes]
		@successes = JSON.parse(session[:successes],:symbolize_names => true)
		session[:successes] = nil
	end
	if session[:infos]
		@infos = JSON.parse(session[:infos],:symbolize_names => true)
		session[:infos] = nil
	end
	if session[:errors]
		@errors = JSON.parse(session[:errors],:symbolize_names => true)
		session[:errors] = nil
	end
end

after do
	if session[:values]
		session[:values] = session[:values].to_json
	end
	if session[:successes]
		session[:successes] = session[:successes].to_json
	end
	if session[:infos]
		session[:infos] = session[:infos].to_json
	end
	if session[:errors]
		session[:errors] = session[:errors].to_json
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
