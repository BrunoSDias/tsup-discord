class MessageGroupsController < ApplicationController
  before_action :set_message_group, only: %i[ show edit update destroy ]

  # GET /message_groups or /message_groups.json
  def index
    @message_groups = MessageGroup.all
  end

  # GET /message_groups/1 or /message_groups/1.json
  def show
  end

  # GET /message_groups/new
  def new
    @message_group = MessageGroup.new
  end

  # GET /message_groups/1/edit
  def edit
  end

  # POST /message_groups or /message_groups.json
  def create
    @message_group = MessageGroup.new(message_group_params)

    respond_to do |format|
      if @message_group.save
        format.html { redirect_to message_group_url(@message_group), notice: "Message group was successfully created." }
        format.json { render :show, status: :created, location: @message_group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /message_groups/1 or /message_groups/1.json
  def update
    respond_to do |format|
      if @message_group.update(message_group_params)
        format.html { redirect_to message_group_url(@message_group), notice: "Message group was successfully updated." }
        format.json { render :show, status: :ok, location: @message_group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /message_groups/1 or /message_groups/1.json
  def destroy
    @message_group.destroy

    respond_to do |format|
      format.html { redirect_to message_groups_url, notice: "Message group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message_group
      @message_group = MessageGroup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_group_params
      params.require(:message_group).permit(:user_chatroom_id)
    end
end
