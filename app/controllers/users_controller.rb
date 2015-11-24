class UsersController < ApplicationController
  before_action :correct_user,   only: [:edit, :update]
  before_action :logged_in_user, only: [:index, :following, :followers]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def new
  	@user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @entries = @user.entries.paginate(page: params[:page])
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  	  log_in(@user)
  	  flash[:info] = "Thank you for your register account."
  	  redirect_to root_url
  	else
  	  render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private 

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
