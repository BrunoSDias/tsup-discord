class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]

  def index
    @messages = Message.all
  end

  def show
  end

  def new
    @message = Message.new
  end

  def edit
  end

  def create
    @message = Message.new(message_params)
    @message.user_chatroom = UserChatroom.find_by(user_id: @current_user.id, chatroom_id: params[:message][:chatroom_id])

    respond_to do |format|
      if @message.save
        Turbo::StreamsChannel.broadcast_append_to "chatroom_#{params[:message][:chatroom_id]}_messages", target: "messages", partial: "messages/message", locals: { user: @current_user, message: @message }

        format.html { redirect_to message_url(@message), notice: "Message was successfully created." }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to message_url(@message), notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:user_chatroom_id, :content)
    end
end
