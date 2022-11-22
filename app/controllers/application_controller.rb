class ApplicationController < ActionController::Base
  before_action :authenticate

  def authenticate
    @current_user ||= begin
      User.find(cookies.encrypted[:user_id]) if cookies.encrypted[:user_id]
    rescue StandardError
      nil
    end

    unless @current_user
      cookies.encrypted[:user_id] = nil
      redirect_to '/sessions/signin/new'
    end
  end

  def total_pending_friendships_request
    @total_friendship_requests_received = FriendshipRequest.where(target_id: @current_user).load_async.count
  end

  def friendship_users(extra_conditions = '')
    @friendship_users = @current_user.friendship_users(extra_conditions: extra_conditions)
  end
end
