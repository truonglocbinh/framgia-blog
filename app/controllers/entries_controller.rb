class EntriesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]

  def create
  	@entry = current_user.entries.build(entry_params)
  	if @entry.save
  	  flash[:success] = "Entry created !"
  	  redirect_to root_url
  	else
      @feed_items = current_user.feed.paginate(page: params[:page])
  	  render 'static_pages/home'
  	end
  end

  def all_comment
    @entry_id = params[:entry_id]
    @comments = Entry.find(@entry_id).comments

    respond_to do |format| 
      format.js {}
    end
  end

  def destroy
  	@entry.destroy
    flash[:success] = "Entry deleted"
    redirect_to request.referrer || root_url
  end
  
  private

  def entry_params
    params.require(:entry).permit(:title, :body)	
  end

  def correct_user
    @entry = current_user.entries.find_by(id: params[:id])
    redirect_to root_url if @entry.nil?
  end
end
