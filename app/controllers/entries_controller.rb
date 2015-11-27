class EntriesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]

  def show
    @entry = Entry.find(params[:id])
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def update
    @entries = Entry.all
    @entry = Entry.find(params[:id])
    @entry.update_attributes(entry_params)
  end

  def create
  	@entry = current_user.entries.build(entry_params)
  	if @entry.save
  	  
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 4)
  	  respond_to do |format|
        format.html { render 'static_pages/home' }
        format.js {}
      end
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
    @feed_items = current_user.feed.paginate(page: params[:page], per_page: 4)
    respond_to do |format|
      format.js {}
    end
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
