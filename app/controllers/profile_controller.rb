class ProfileController < ApplicationController
  def show
    @user = User.find_by_username(params[:username])
    if @user
      @statuses = Status.all
      render :show
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end
end
