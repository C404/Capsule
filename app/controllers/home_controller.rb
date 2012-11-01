class HomeController < ApplicationController

  def index
    @capsuls = Capsul.all(:limit => 10, :order=> 'created_at desc')
    @capsul = Capsul.new
  end

end
