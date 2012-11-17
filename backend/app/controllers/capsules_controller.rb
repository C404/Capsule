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

  api :GET, '/users/:user_id/capsules', 'Get a user\'s published capsules'
  api :GET, '/capsules', 'Get recent/featured capsules'
  def index
  end

  api :GET, '/capsules/search/:search_query', 'Search for great capsules'
  def search
  end

  api :GET, '/capsules/:id', 'Get a specific capsule detailes description'
  def show
  end

  api :GET, '/users/:user_id/capsules/new', 'Get an empty capsule definition'
  def new
  end

  api :POST, '/users/:user_id/capsules', 'Create a new capsule'
  def create
  end

  api :PUT, '/capsules/:id', 'Update a capsule information'
  def update
  end

  api :DELETE, '/capsules/:id', 'Maybe it was a bad idea to caps that ... can u delete it ?'
  def destroy
  end
end

