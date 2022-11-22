class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: %i[ show edit update destroy ]

  # GET /chatrooms or /chatrooms.json
  def index
    @chatrooms = Chatroom.all
  end

  # GET /chatrooms/1 or /chatrooms/1.json
  def show
    load_show_requirements(@chatroom)
  end

  def direct
    @chatroom = Chatroom.search_chatroom([@current_user.id, params[:target_id].to_i]).first
    if @chatroom.present?
      load_show_requirements(@chatroom)

      render 'chatrooms/show'
    end
  end

  # GET /chatrooms/new
  def new
    @chatroom = Chatroom.new
  end

  # GET /chatrooms/1/edit
  def edit
  end

  # POST /chatrooms or /chatrooms.json
  def create
    @chatroom = Chatroom.new
    respond_to do |format|
      valid, content = @chatroom.start(current_user_id: @current_user.id, other_user_ids: chatroom_params[:user_ids])
      if valid
        @chatroom = content
        load_show_requirements(@chatroom)
        
        render 'chatrooms/show'
        return
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  # PATCH/PUT /chatrooms/1 or /chatrooms/1.json
  def update
    respond_to do |format|
      if @chatroom.update(chatroom_params)
        format.html { redirect_to chatroom_url(@chatroom), notice: "Chatroom was successfully updated." }
        format.json { render :show, status: :ok, location: @chatroom }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chatroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chatrooms/1 or /chatrooms/1.json
  def destroy
    @chatroom.destroy

    respond_to do |format|
      format.html { redirect_to chatrooms_url, notice: "Chatroom was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def load_show_requirements(chatroom)
      @users = User
      .joins(:user_chatrooms)
      .where(user_chatrooms: { chatroom_id: chatroom.id })
      .where.not(user_chatrooms: { user_id: @current_user.id })

      @message_groups = MessageGroup.includes([{user_chatroom: :user}, :messages]).where(user_chatrooms: { chatroom_id: chatroom.id })
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_chatroom
      @chatroom = Chatroom.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chatroom_params
      params.fetch(:chatroom, {})
    end
end
