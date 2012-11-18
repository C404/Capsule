##
## api_controller.rb
## Login : <lta@still.akr.fm>
## Started on  Sat Nov  3 03:34:43 2012 Lta Akr
## $Id$
##
## Author(s):
##  - Lta Akr <>
##
## Copyright (C) 2012 Lta Akr
##

class ApiController < RocketPants::Base
  extend Apipie::DSL
  #before_filter :auth_current_user
  #jsonp


  protected
  attr_accessor :current_user

  def auth_current_user
    session = Session.where(token: params[:token]).first
    error! :unauthenticated if session.nil?
    @current_user = session.user
  end

  def belongs_to_user!
    error! :unauthenticated if o.user_id != @current_user.id
  end

end
