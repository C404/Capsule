##
## capsules_controller.rb
## Login : <lta@still>
## Started on  Sat Nov 17 12:46:49 2012 Lta Akr
## $Id$
##
## Author(s):
##  - Lta Akr <>
##
## Copyright (C) 2012 Lta Akr
##

class CapsulesController < ApiController
  version 1

  resource_description do
    name 'Capsule'
    short 'Capsule posted by users on their accounts'
    path '/capsules'
    version '0.1'
    formats ['json']
  end

  skip_before_filter :auth_current_user
  api :GET, '/users/:user_id/capsules', 'Get a user\'s published capsules'
  api :GET, '/capsules', 'Get recent/featured capsules'
  def index
    if params[:user_id] #and User.find(params[:user_id])
      expose 'unimplemented'
      #expose User.capsules.order('created_at ASC').page(params[:page])
    else
      expose Capsule.asc(:created_at).page(params[:page])
    end
  end

  api :GET, '/capsules/search/:search_query', 'Search for great capsules'
  param :search_query, Session, desc: "A list of comma separated hashtags to search for (without the #)"
  def search
    error! :bad_request unless params[:search_query]
    tags = params[:search_query].split(',').map { |s| "##{s}"}
    puts tags
    expose Capsule.where(hashtags: tags).asc(:created_ed).page params[:page]
  end

  api :GET, '/capsules/:id', 'Get a specific capsule detailes description'
  def show
    expose Capsule.find(params[:id])
  end

  api :GET, '/users/:user_id/capsules/new', 'Get an empty capsule definition'
  def new
    load_user!
    expose @user.capsules.build
  end

  api :POST, '/users/:user_id/capsules', 'Create a new capsule'
  def create
    # load_user!
    # @user.capsules.create!(params[:capsule])
    capsule = Capsule.new(params[:capsule])
    capsule.video = params[:file]
    capsule.save!
  end

  api :PUT, '/capsules/:id', 'Update a capsule information'
  def update
    capsule = Capsule.find(params[:id])
    capsule.update_attributes!(params[:capsule])
  end

  api :DELETE, '/capsules/:id', 'Maybe it was a bad idea to caps that ... can u delete it ?'
  def destroy
    capsule = Capsule.find(params[:id])
    capsule.destroy
  end

  private
  def load_user!
    @user = User.find(params[:user_id])
    error! :not_found unless user
  end
end

