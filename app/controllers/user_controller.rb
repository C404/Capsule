class UserController < ApplicationController

  def show
    redirect_to root_path if current_user.id ==  params[:id].to_i
    @user ||= User.find(params[:id])


    redirect_to root_path, :notice => "user don't exist !" if not @user
    @capsuls = @user.capsuls
  end
end
