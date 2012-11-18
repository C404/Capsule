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


  skip_before_filter :auth_current_user, :only => [:index, :show, :new, :create]

  api :GET, '/users/', "List registered users"
  def index
    expose User.all 
  end

  api :GET, '/users/:id', "Retrieve info about a user"
  def show
    expose User.find_by_id params[:user_id]
  end

  ##################################
  # User registration and management

  api :GET, '/users/new', 'Get a prototype for user users, as well as a captcha :p'
  def new
    @user = User.new
    expose @user
  end

  param :username, String, desc: "Username", required: true
  param :password, String, desc: "Password", required: true
  api :POST, '/users', 'Create a user account'
  def create
    @user = User.create
    @user.update_attributes username: Digest::SHA1.hexdigest("#{@user.id}_capsule_username"),
    password: Digest::SHA1.hexdigest("#{@user.id}_capsule_password")
    expose @user
  end


  api :PUT, '/users/:id', 'Update an user account details'
  def update
    @current_user.update_attribute(params['user'])
  end

  api :DELETE, '/users/:id', 'Leaving that soon ?'
  def destroy
    @current_user.delete
  end

end

