class UserFriendshipsController < ApplicationController

  before_filter :authenticate_user!, only: [:new, :create]

  def new

    #debug
    logger.debug "Friend Params: #{friend_params} "

    if friend_params.empty?
      raise ActiveRecord::RecordNotFound
    else
      @friend = User.find(params[:friend_id])
      @user_friendship = current_user.user_friendships.new(friend: @friend)
    end

      #error handler
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Friend not found"

  end

  def create

    if params[:friend_id]
      @friend = friend_params
      logger.debug "#{@friend.inspect}"
      @user_friendship = current_user.user_friendships.new(friend: @friend)
      @user_friendship.save
      flash[:success] = "You are now friend with #{users(:nyk).first_name}"
      redirect_to profile_path(@friend.username)
    else
      flash[:alert] = 'User Required'
      redirect_to root_path
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
