class FriendshipRequestsController < ApplicationController
  before_action :set_friendship_request, only: %i[ accept destroy ]

  def index
    @target_friendship_requests = FriendshipRequest.where(target_id: @current_user).includes(:target)
    @sender_friendship_requests = FriendshipRequest.where(sender_id: @current_user).includes(:sender)
  end

  def new
    @friendship_request = FriendshipRequest.new
  end

  def accept
    if Friendship.create(user1: @friendship_request.sender, user2: @friendship_request.target)
      @friendship_request.destroy

      respond_to do |format|
        format.html { redirect_to friendship_requests_url, notice: 'Solicitação de amizade aceita!' }
        format.turbo_stream { flash.now[:notice] = 'Solicitação de amizade aceita!' }
      end
    else
      @friendship_request.errors.add(:base, 'Houve um erro ao tentar aceitar a solicitação de amizade')
      respond_to do |format|
        format.html { render :index }
        format.turbo_stream
      end
    end
  end

  def create
    @friendship_request = FriendshipRequest.new(sender: @current_user)
    new_friend = User.find_by(email: friendship_request_params[:email])

    unless new_friend
      @friendship_request.errors.add(:base, "Não foi possivel encontrar um usuario com este email")
      render :new, status: :unprocessable_entity
      return
    end
    @friendship_request.target = new_friend

    if @friendship_request.save
      flash.now[:notice] = "Solicitação de amizade enviada com sucesso"
      render :new
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @friendship_request.destroy
    Turbo::StreamsChannel.broadcast_remove_to [@friendship_request.sender, "friendship_requests"], target: @friendship_request
    Turbo::StreamsChannel.broadcast_remove_to [@friendship_request.target, "friendship_requests"], target: @friendship_request
    respond_to do |format|
      format.html { redirect_to friendship_requests_url, notice: "Friendship request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_friendship_request
      @friendship_request = FriendshipRequest.find(params[:id])
    end

    def friendship_request_params
      params.require(:friendship_request).permit(:email)
    end
end
