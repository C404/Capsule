class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, except: [:facebook, :twitter, :linkedin, :dailymotion, :youtube]
  before_filter :is_active!, except: [:step, :validate_step, :facebook, :twitter, :linkedin, :dailymotion, :youtube]


  def is_active!
    if current_user
      if current_user.active == nil or current_user.active == false
        redirect_to profile_step_path, notice: 'You need to finish your registration'
      end
    end
  end


end
