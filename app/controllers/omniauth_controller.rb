class OmniauthController < ApplicationController
  # TODO 4 ALL : Synchronize all providers when user session is on
  # to get maximum of tokens and take care of expirations if its the case.

  # TODO : Make additional db for several email if user logged in manualy and then we get synchronize
  # with facebook / dailymotion and we get some more emails ... We must take care of this !!!!
  # if user actually register with facebook and try to synchronize facebook with a manual made account what happen ?

  # TODO : Code factoring ... Find a way out of huge conditions ...

  def facebook
    auth = request.env['omniauth.auth']
    extra = auth[:extra]
    facebook_email = extra[:raw_info][:email]
    user = User.find_by_email(facebook_email)
    if user.nil? and current_user.nil?
      user = new_user extra, auth, 'fb'
      user.user_token.fb_id = extra[:raw_info][:id]
      user.user_token.save
    elsif current_user and current_user.user_token.nil?
      facebook_email = user_no_token 'fb', extra, auth
      current_user.user_token.fb_id = extra[:raw_info][:id]
      current_user.user_token.save
    elsif current_user
      raise
      facebook_email = current_user_only_need_a_sync 'fb', auth
      current_user.user_token.fb_id = extra[:raw_info][:id]
      current_user.user_token.save
    else
      new_user_need_a_sync 'fb', user, auth
      user.user_token.fb_id = extra[:raw_info][:id]
      user.user_token.save!
    end
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
    if user.nil? and current_user.nil?
      generated_password = Devise.friendly_token.first(6)
      user = User.new(:email => extra[:raw_info][:email],
                      :username => extra[:raw_info][:url].split('/').last,
                      :password => generated_password)
      user.save!
      user.build_user_token(:da_token => auth[:credentials][:token])
      user.user_token.save
    elsif current_user and current_user.user_token.nil?
      current_user.build_user_token(:da_token => auth[:credentials][:token],
                                    :da_email => extra[:raw_info][:email])
      current_user.user_token.save
      dailymotion_email = current_user.email
    elsif current_user
      current_user.user_token.da_token = auth[:credentials][:token]
      current_user.user_token.save
      dailymotion_email = current_user.email
    else
      user.user_token.da_token = auth[:credentials][:token]
      user.user_token.save
    end
    respond_to do |format|
      format.html { redirect_to omni_session_connect_path(:mail => dailymotion_email) }
    end
  end

  private

  def new_user extra, auth, provider
    token = provider + '_token'
    generated_password = Devise.friendly_token.first(6)
    user = User.new(:email => extra[:raw_info][:email],
                    :username => extra[:raw_info][:name],
                    :password => generated_password)
    user.save
    user.build_user_token(token.to_s => auth[:credentials][:token])
    user.user_token.save
    return user
  end

  def user_no_token provider, extra, auth
    token = provider + '_token'
    p_email = provider + '_email'
    username = provider + '_username'
    current_user.build_user_token(token.to_s => auth[:credentials][:token],
                                  p_email.to_s => extra[:raw_info][:email],
                                  username.to_s => extra[:raw_info][:name])
    current_user.user_token.save
    return current_user.email
  end
  
  def current_user_only_need_a_sync provider, auth
    if provider == 'fb'
      current_user.user_token.fb_token = auth[:credentials][:token]
    elsif provider == 'da'
      current_user.user_token.da_token = auth[:credentials][:token]
    end
    current_user.user_token.save
    return current_user.email
  end

  def new_user_need_a_sync provider, user, auth
    if provider == 'fb'
      user.user_token.fb_token = auth[:credentials][:token]
    elsif provider == 'da'
      current_user.user_token.da_token = auth[:credentials][:token]
    end
    user.user_token.save
  end

end
