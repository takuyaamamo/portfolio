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
    @cart = session[:cart].map { |item_id, item_count| Item.find(item_id.to_i) }
    @purchased_history = PurchasedHistory.new
    @purchased_item = PurchasedItem.new
    respond_to do |format|
      format.js
    end
  end

  # GET /purchased_histories/1/edit
  def edit
  end

  # POST   /purchased_histories カート画面フォームのsubmit後
  def create
    if params[:close]# カートの閉じるボタン後
      if session[:cart].present?
        session[:cart] = params[:post][:purchased_item]
      end
    elsif params[:update]# カートの在庫更新ボタン後
      if session[:cart].present?
        params[:post][:purchased_item].each do |item_id, item_count|
          item = Item.find(item_id.to_i)
          stock = Stock.find(item.id)
          stock.stock_count = item_count["item_count"].to_i
          stock.save
          session[:cart].delete(item_id)
        end
      end
    else

    end
  end

  # POST   /purchased_histories/sessioncreate 商品詳細画面のsubmit後
  def sessioncreate
    # item_count
    item_count = params[:purchased_item][:item_count].to_i
    item = { item_count: item_count }
    # item_idはstring
    params[:item_id] = params[:purchased_item][:item_id]
    # session[:cart]に同じ商品があれば個数を増やす
    if session[:cart].has_key?(params[:item_id])
      session_item_count = session[:cart][params[:item_id]]["item_count"]
      session[:cart][params[:item_id]]["item_count"] = session_item_count.to_i + item_count
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
  end
  # DELETE /purchased_histories/1
  # DELETE /purchased_histories/1.json
  def sessiondestroy
    session[:cart].delete(params[:id])
    @cart = session[:cart].map { |item_id, item_count| Item.find(item_id.to_i) }
    respond_to do |format|
      format.html { redirect_to purchased_histories_url, notice: 'Purchased history was successfully destroyed.' }
      format.json { head :no_content }
      format.js
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
