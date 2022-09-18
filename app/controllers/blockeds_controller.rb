class BlockedsController < ApplicationController
  before_action :set_blocked, only: %i[ destroy ]

  def index
    @blockeds = @current_user.blockeds.includes(:target)
  end

  def create
    @blocked = Blocked.new(blocked_params)

    respond_to do |format|
      if @blocked.save
        format.html { redirect_to blocked_url(@blocked), notice: "Blocked was successfully created." }
        format.json { render :show, status: :created, location: @blocked }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blocked.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @blocked.destroy

    respond_to do |format|
      format.html { redirect_to blockeds_url, notice: "Blocked was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_blocked
      @blocked = Blocked.find(params[:id])
    end

    def blocked_params
      params.require(:blocked).permit(:sender_id, :target_id)
    end
end
