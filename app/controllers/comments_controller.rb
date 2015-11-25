class CommentsController < ApplicationController
  def create
  	@comment = Comment.new
  	@comment.content = params[:value]
  	@comment.user_id = current_user.id
  	@comment.entry_id = params[:entry_id].to_i
  	if @comment.save
      @comments = Entry.find( @comment.entry_id ).comments.limit(3)
  	  respond_to do |format| 
        format.js { render "entries/show_comment.js.erb"}
      end
  	else
      redirect_to root_url
  	end
  end
  
  def destroy
  	@comment = Comment.find(params[:id])
    if @comment.destroy
      respond_to do |format|
        format.html { redirect_to  request.referer}
      end
    else
      redirect_to root_url
    end
  end
end
