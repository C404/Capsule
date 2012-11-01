class OmniauthController < ApplicationController

  def set_user_info extra
    user = User.new(
    :email => extra[:raw_info][:email],
    :capsules => 0,
    :active => true)
    if extra[:raw_info][:location]
      user.location = extra[:raw_info][:location][:name]
    end
    user.username = extra[:raw_info][:name]
    if extra[:raw_info][:gender].to_s == "male"
      user.gender = 1
    else
      user.gender = 2
    end
    user.save
    return user
  end


  def facebook
    auth = request.env['omniauth.auth']
    extra = auth[:extra]
    user = User.find_by_email(extra[:raw_info][:email])
    if user.nil?
      user = set_user_info extra
    end
    sign_in user
    redirect_to root_path, :notice => 'vous etes co wesh !'
  end


  def twitter
  end


  def linkedin
  end

  def dailymotion
  end

  def youtube
  end


end
