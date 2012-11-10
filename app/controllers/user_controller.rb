class UserController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def me
    if current_user
      user = User.find(current_user.id)
      @capsuls = user.capsuls.order('created_at DESC')
    end
  end


  def show
    @user = User.find(params[:id])
    @capsuls = @user.capsuls
    if current_user and current_user.id == params[:id].to_i
      redirect_to user_me_url
    end
  end
end
