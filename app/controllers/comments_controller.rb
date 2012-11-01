class CommentsController < ApplicationController

  def create
    @capsul = Capsul.find(params[:capsul_id])
    @comment = @capsul.comments.new
    @comment.content = params[:comment][:content]
    @comment.user_id = current_user.id
    @comment.save
 
    redirect_to capsul_path(@capsul)
  end
end
