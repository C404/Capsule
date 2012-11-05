class OmniauthController < ApplicationController

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
    end
    respond_to do |format|
      format.html { redirect_to omni_session_connect_path(:mail => facebook_email) }
    end
  end

end
