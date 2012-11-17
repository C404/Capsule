##
## users_controller.rb
## Login : <lta@still>
## Started on  Sat Nov 17 12:47:18 2012 Lta Akr
## $Id$
##
## Author(s):
##  - Lta Akr <>
##
## Copyright (C) 2012 Lta Akr
##

class UsersController < ApiController
  version 1

  resource_description do
    name 'User'
    short 'Information about capsule publishers'
    path '/users'
    version '0.1'
    formats ['json']
  end

  api :GET, '/users/', "List registered users"
  def index
  end

  api :GET, '/users/:id', "Retrieve info about a user"
  def show
  end

  ##################################
  # User registration and management

  api :GET, '/users/new', 'Get a prototype for user users, as well as a captcha :p'
  def new
  end

  api :POST, '/users', 'Create a user account'
  def create
  end

  api :PUT, '/users/:id', 'Update an user account details'
  def update
  end

  api :DELETE, '/users/:id', 'Leaving that soon ?'
  def destroy
  end

end

