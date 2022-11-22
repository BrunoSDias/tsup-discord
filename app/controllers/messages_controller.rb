class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]

  def index
    @messages = Message.all
  end

  def show
    @pos = params[:pos]
  end

  def new
    @message = Message.new
  end

  def edit
    @pos = params[:pos]
  end

  def create
    message = Message.new(message_params)
    user_chatroom = UserChatroom.find_by(user_id: @current_user.id, chatroom_id: params[:message][:chatroom_id])
    message_group = MessageGroup
                      .joins(:user_chatroom)
                      .where(user_chatrooms: { chatroom_id: params[:message][:chatroom_id]})
                      .order(created_at: :desc)
                      .first
    
    message.message_group_id = begin
      if message_group && message_group.user_chatroom_id == user_chatroom.id
        message_group.id
      else
        MessageGroup.create(user_chatroom_id: user_chatroom.id).id
      end
    end

    respond_to do |format|
      if message.save
        Turbo::StreamsChannel.broadcast_append_to "chatroom_#{params[:message][:chatroom_id]}_message_groups", target: "message_groups", partial: "message_groups/message_group", locals: { user: @current_user, message_group: message.message_group }

        format.html { redirect_to message_url(@message), notice: "Message was successfully created." }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  def update
    @pos = params[:pos]
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to messages_url(@message), notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @attachment_ids = @message.attachments.pluck(:id)
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
      format.turbo_stream
    end
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:message_group_id, :content, attachments: [])
    end
end
