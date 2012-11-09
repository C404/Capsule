class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    if current_user
      user = User.find(current_user.id)
      @capsuls = user.capsuls.order('created_at DESC')
    end
  end
end
