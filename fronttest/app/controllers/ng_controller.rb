class NgController < ApplicationController
#  layout false

  def view
    render params[:page]
  end
end
