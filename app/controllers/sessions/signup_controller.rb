class Sessions::SignupController < Sessions::ApplicationController
  def new
  end

  def create
    user = User.new(session_params)
    if user.save
      session[:user_id] = user.id
      redirect_to root_path
    end
  end

  private
  def session_params
    params.require(:session).permit(:name, :email, :password, :password_confirmation, :avatar)
  end
end
