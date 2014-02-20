class TimecardsController < ApplicationController
  before_action :set_timecard, only: [:show, :edit, :update, :destroy]

  # GET /timecards
  # GET /timecards.json
  def index
    @timecards = Timecard.all
  end

  # GET /timecards/1
  # GET /timecards/1.json
  def show
  end

  # GET /timecards/new
  def new
    @timecard = Timecard.new
  end

  # GET /timecards/1/edit
  def edit
  end
  
  def account
    @timecards = Timecard.all
    @card = Timecard.new
  end
  
  def admin
    @timecards = Timecard.all
    @users = User.all
  end

  def getTotal
    cards = current_user.timecards.where("timeout is not null")
    total = 0
    cards.each do |c|
      total = total + (c.timeout - c.timein).to_f
    end
    current_user.t_hours = (total/60/60).round(2)
    current_user.save
  end
  
  def getWeekly
    d = Date.today
    wHours = 0
    range = (d.at_beginning_of_week.to_datetime..d.at_end_of_week.to_datetime)
    if !current_user.timecards.where(timeout: range).nil?
      cards = current_user.timecards.where(timeout: range)
      cards.each do |c|
        wHours = wHours + (c.timeout - c.timein).to_f 
      end
      current_user.week_hours = (wHours/60/60).round(2)
    else
      current_user.week_hours = 0
    end
    current_user.save
  end
      
  # POST /timecards
  # POST /timecards.json
  def create
    if current_user.activecard?
      if !current_user.timecards.where("timeout is null").first.nil?
        card = current_user.timecards.where("timeout is null").first
        if !(card.timein.strftime("%e").to_i == Time.now.strftime("%e").to_i).nil?
          card.timeout = Time.now
          card.save
          getTotal
          getWeekly
          current_user.activecard = false
        else
          card.destroy
        end
      else
        current_user.activecard = false
      end
      current_user.save
    else
      card = Timecard.new
      card.timein = Time.now
      card.user_id = current_user.id
      card.save
      getTotal
      getWeekly
      current_user.activecard = true
      current_user.save
    end
    redirect_to account_path
  end

  # PATCH/PUT /timecards/1
  # PATCH/PUT /timecards/1.json
  def update
    respond_to do |format|
      if @timecard.update(timecard_params)
        format.html { redirect_to @timecard, notice: 'Timecard was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @timecard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /timecards/1
  # DELETE /timecards/1.json
  def destroy
    @timecard.destroy
    respond_to do |format|
      format.html { redirect_to timecards_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timecard
      @timecard = Timecard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def timecard_params
      params.require(:timecard).permit(:timein, :timeout, :user_id)
    end
end
