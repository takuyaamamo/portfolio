class PurchasedHistoriesController < ApplicationController
  before_action :set_purchased_history, only: [:show, :edit, :update, :destroy]

  # GET /purchased_histories
  # GET /purchased_histories.json
  def index
    @purchased_histories = PurchasedHistory.all
  end

  # GET /purchased_histories/1
  # GET /purchased_histories/1.json
  def show
  end

  # GET /purchased_histories/new
  def new
    @purchased_history = PurchasedHistory.new
  end

  # GET /purchased_histories/1/edit
  def edit
  end

  def create
  end

  def sessioncreate
    # item_count
    item_count = params[:post][:purchased_item][:item_count].to_i
    item = { item_count: item_count }
    # item_idはstring
    params[:item_id] = params[:post][:purchased_item][:item_id]
    if session[:cart].has_key?(params[:item_id])
      session[:cart][params[:item_id]]["item_count"] +=  item_count
    else
      session[:cart][params[:item_id]] = item
      @item = Item.find(params[:item_id].to_i)
    end
    respond_to do |format|
      format.js
    end
  end

  # PATCH/PUT /purchased_histories/1
  # PATCH/PUT /purchased_histories/1.json
  def update
    respond_to do |format|
      if @purchased_history.update(purchased_history_params)
        format.html { redirect_to @purchased_history, notice: 'Purchased history was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchased_history }
      else
        format.html { render :edit }
        format.json { render json: @purchased_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchased_histories/1
  # DELETE /purchased_histories/1.json
  def destroy
    @purchased_history.destroy
    respond_to do |format|
      format.html { redirect_to purchased_histories_url, notice: 'Purchased history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchased_history
      @purchased_history = PurchasedHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchased_history_params
      params.require(:purchased_history).permit(:user_name, :postal_code, :address, :phone_number, :email_address, :shipping, :created_at, :updated_at, purchased_items_attributes: [:id, :purchased_history_id, :item_id, :item_count, :_destroy])
    end
end
