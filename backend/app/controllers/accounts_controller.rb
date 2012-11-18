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
  # version 1

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

  api :GET, 'accounts/:service/*callback/callback',
            'Initiate a new account association using OAuth or similar mechanism'
  def new
    # redirect_to root_url + "/auth/#{params[:service]}?callback=#{params[:callback]}"
    # logger.info request.query_string
#    redirect_to root_url + "/auth/#{params[:service]}?capsulecallback=helloworld"
    
    if params[:service] == 'facebook'
      init_fb ERB::Util::url_encode(params[:callback])
      redirect_to @oauth.url_for_oauth_code(:permissions => SERVICES_SETTINGS[:facebook][:permissions])
    end
    
  end

  def auth_callback
    if params[:service] == 'facebook'
      init_fb params[:auth_callback_param]
      #
      @oauth.get_access_token_info(params[:code])
      redirect_to CGI::unescape params[:auth_callback_param]
    end
  end

  private
  def init_fb url_ret
      @oauth = Koala::Facebook::OAuth.new(SERVICES_SETTINGS[:facebook][:id],
                                        SERVICES_SETTINGS[:facebook][:secret],
                                        auth_callback_url('facebook', url_ret))
  
    logger.info auth_callback_url('facebook', url_ret)
  end
  
end

