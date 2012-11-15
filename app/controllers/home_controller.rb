class HomeController < ApplicationController
  # GET /
  def index
    @limit = 10
    @offset = 0
    if params[:limit] and Integer(params[:limit]) > 100
      @limit = 100
    end
    if params[:offset]
      @offset = Integer(params[:offset])
    end
    @capsuls = Capsul.order('created_at DESC').limit(@limit).offset(@offset).all
    @user_capsuls = nil
    @random_capsuls = Capsul.order("RANDOM()").limit(@limit).offset(@offset).all
    if current_user
      user = User.find(current_user.id)
      @user_capsuls = user.capsuls.order('created_at DESC').limit(@limit).offset(@offset)
    end
    respond_to do |format|
      format.html
    end
  end
end
