##
## accounts_controller.rb
## Login : <lta@still>
## Started on  Sat Nov 17 14:50:57 2012 Lta Akr
## $Id$
##
## Author(s):
##  - Lta Akr <>
##
## Copyright (C) 2012 Lta Akr
##

class AccountsController < ApiController
  version 1

  resource_description do
    name 'Attached accounts'
    short 'Authorization and credentials management for third party services account'
    path '/users/:user_id/:service'
    version '0.1'
    formats ['json']
  end

  api :GET, '/users/:user_id/:service/accounts', 'Lists the associated accounts'
  def index
  end

  api :GET, '/users/:user_id/:service/accounts/new',
            'Initiate a new account association using OAuth or similar mechanism'
  def new
  end
end

