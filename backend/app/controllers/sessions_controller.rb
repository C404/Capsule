##
## sessions_controller.rb
## Login : <lta@still>
## Started on  Sat Nov 17 12:28:29 2012 Lta Akr
## $Id$
##
## Author(s):
##  - Lta Akr <>
##
## Copyright (C) 2012 Lta Akr
##

class SessionsController < ApiController
  version 1
  
  resource_description do
    name 'Session'
    short 'Representing an authenticated user on Capsule\'s API'
    path '/sessions'
    version '0.1'
    formats ['json']
  end

  
  skip_before_filter :auth_current_user, :only => [:create]
  api :POST, '/sessions', 'Get a session token'
  param :username, String, desc: "Username", required: true
  param :password, String, desc: "Username", required: true
  
  def create
    u = User.where(username: params[:username], password: params[:password]).first
    error! :unauthenticated if u.nil?
    logger.info u.inspect
    if (@session = u.sessions.first).nil?
      @session = u.sessions.create
      @session.update_attribute :token, Digest::SHA1.hexdigest("#{@session.id}_#{u.id}_capsule_token")
    end
    expose @session
  end

  api :DELETE, '/sessions/:id', 'Destroy a session id / disconnects'
  param :token, String, desc: "Session token", required: true
  def destroy
    @session = Session.where(token: params[:token]).first
    belongs_to_user! @session
    @session.delete
    expose :ok 
  end
end
