class UserFriendshipsController < ApplicationController

  before_filter :authenticate_user!, only: [:new]

  def new
    logger.debug "Friend Params: #{friend_params} "
    if friend_params.empty?
      flash[:alert] = "Friend not found"
    else
      @friend = User.find(params[:friend_id])
      @user_friendship = UserFriendship.new(friend: @friend)
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


end
