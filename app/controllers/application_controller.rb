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
end
