class UserFriendshipsController < ApplicationController

  before_filter :authenticate_user!, only: [:new, :create, :update, :destroy]

  def new
    if params[:friend_id].empty?
      raise ActiveRecord::RecordNotFound
    else
      @friend = User.find(params[:friend_id])
      @user_friendship = current_user.user_friendships.create
    end

    #error handler
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "Friend not found"

  end

  def create
    respond_to do
      if params[:user_friendship][:friend_id]
        @friend = User.find(params[:user_friendship][:friend_id])
        if current_user.user_friendships.find_by_friend_id(@friend)
          flash[:alert] = "You are already friends with #{@friend.first_name}"
          redirect_to profile_path(@friend.username)
        else
          @user_friendship = current_user.user_friendships.new(friend: @friend)
          @user_friendship.save
          flash[:success] = "You are now friends with #{@friend.first_name}"
          redirect_to profile_path(@friend.username)
        end
      else
        flash[:alert] = 'User Required'
        redirect_to root_path
      end
    end
  end

  def update

    if params[:user_friendship][:friend_id]
      @friend = User.find(params[:user_friendship][:friend_id])
      @user_friendship = current_user.user_friendships.create(friend: @friend)
    end

  end

  private

  # Use callbacks to share common setup or constraints between actions.
  #def set_status
  #  @status = Status.find(params[:id])
  #end

  # Never trust parameters from the scary internet, only allow the white list through.
  def friend_params
    params.permit(:friend_id)
  end

  def friend_error
    flash[:alert] = "Friend not found"
  end

end
