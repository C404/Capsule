class OmniSessionController < ApplicationController

  def connect
    user = User.find_by_email(params[:mail])
    sign_in user
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Welcome #{user.username} !" }
    end
  end

end
