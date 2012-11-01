class ProfileController < ApplicationController
  before_filter :is_my_profile, except: [:search, :all, :step, :validate_step]

  def profile
    @user_profile = User.find(params[:user_id])
  end

  def me
    
  end

  def search
  end

  def all
  end

  # formular before we activate user profile
  # in validate_step
  def step
    @me = User.find(current_user.id)
  end

  # We set user profiles and activate the account
  def validate_step
    current_user.active = true
    current_user.capsules = 0
    current_user.username = params[:user][:username]
    current_user.location = params[:user][:location]
    current_user.gender = params[:user][:gender]
    current_user.save
    redirect_to root_path, notice: 'Profile complet !'
  end

  # check if we must print owner profile as me or 
  # someone else profile as /:user_id/profile
  def is_my_profile
    if params[:user_id].to_i == current_user.id
      redirect_to profile_me_path
    end
  end

end
