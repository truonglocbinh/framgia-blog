class CommentsController < ApplicationController
  def create
  	@comment = Comment.new
  	@comment.content = params[:comment][:content]
  	@comment.user_id = current_user.id
  	@comment.entry_id = params[:comment][:entry_id]
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
    @entry_id = @comment.entry_id
    if @comment.destroy
      @comments = Entry.find(@comment.entry_id).comments
      respond_to do |format|
        format.js {}
      end
    else
      redirect_to root_url
    end
  end
end
