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

  api :POST, '/sessions', 'Get a session id'
  def create
  end

  api :DELETE, '/sessions/:id', 'Destroy a session id / disconnects'
  def destroy 
  end
end
