class OmniauthController < ApplicationController
  # TODO 4 ALL : Synchronize all providers when user session is on
  # to get maximum of tokens and take care of expirations if its the case.

  def facebook
    auth = request.env['omniauth.auth']
    extra = auth[:extra]
    facebook_email = extra[:raw_info][:email]
    user = User.find_by_email(facebook_email)
    if user.nil?
      generated_password = Devise.friendly_token.first(6)
      user = User.new(:email => extra[:raw_info][:email],
                      :username => extra[:raw_info][:name],
                      :password => generated_password)
      user.save!
      user.build_user_token(:fb_token => auth[:credentials][:token])
      user.user_token.save!
    end
    user.user_token.fb_token = auth[:credentials][:token]
    user.user_token.save!
    respond_to do |format|
      format.html { redirect_to omni_session_connect_path(:mail => facebook_email) }
    end
  end

  # todo : Token expire = true // expire time a prendre en compte
  # refresh_token a prendre ? // Auth avec dailymotion a reconfirmer a chaque fois ...

  def dailymotion
    auth = request.env['omniauth.auth']
    extra = auth[:extra]
    dailymotion_email = extra[:raw_info][:email]
    user = User.find_by_email(dailymotion_email)
    if user.nil?
      generated_password = Devise.friendly_token.first(6)
      user = User.new(:email => extra[:raw_info][:email],
                      :username => extra[:raw_info][:url].split('/').last,
                      :password => generated_password)
      user.save!
      user.build_user_token(:da_token => auth[:credentials][:token])
      user.user_token.save!
    end
    user.user_token.da_token = auth[:credentials][:token]
    user.user_token.save!
    respond_to do |format|
      format.html { redirect_to omni_session_connect_path(:mail => dailymotion_email) }
    end
  end

end
