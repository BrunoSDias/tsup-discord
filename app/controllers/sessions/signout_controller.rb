class Sessions::SignoutController < Sessions::ApplicationController
  def destroy
    cookies.encrypted[:user_id] = nil
    redirect_to '/sessions/signin/new'
  end
end
