class UsersController < ApplicationController
  def set_status
    @current_user.status = params[:status]
    if @current_user.save
      respond_to do |format|
        format.js
      end
      @current_user.broadcast_status
    end
  end
end
