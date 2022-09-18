class Sessions::SignoutController < Sessions::ApplicationController
  def destroy
    session[:user_id] = nil
    redirect_to '/sessions/signin/new'
  end
end
