class ApplicationController < ActionController::Base
  before_action :authenticate

  def authenticate
    @current_user ||= begin
      User.find(session[:user_id]) if session[:user_id]
    rescue StandardError
      nil
    end

    unless @current_user
      session[:user_id] = nil
      redirect_to '/sessions/signin/new'
    end
  end
end
