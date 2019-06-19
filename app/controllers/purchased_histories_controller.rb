class PurchasedHistoriesController < ApplicationController
  before_action :set_purchased_history, only: [:show, :edit, :update, :destroy]

  # GET /purchased_histories/new
  def new
    @cart = session[:cart].map { |item_id, item_count| Item.find(item_id.to_i) }
    @purchased_history = PurchasedHistory.new
    @purchased_item = PurchasedItem.new
    respond_to do |format|
      format.js
    end
  end

  # purchased_histories POST   /purchased_histories カート画面フォームのsubmit後
  def create
    if params[:close]# カートの閉じるボタン後
      if session[:cart].present?
        session[:cart] = params[:purchased_item]
      end
    elsif params[:update]# カートの在庫更新ボタン後
      if session[:cart].present?
        params[:purchased_item].each do |item_id, item_count|
          item = Item.find(item_id.to_i)
          stock = Stock.find_by(item_id: item.id)
          stock.stock_count = item_count["item_count"].to_i
          stock.save
          session[:cart].delete(item_id)
        end
      end
    elsif params[:buy]# カートの銀行振込ボタン後
      binding.pry
      if session[:cart].present?
        @purchased_history = PurchasedHistory.new
        @purchased_history.user_name = params[:user_name]
        @purchased_history.postal_code = params[:postal_code]
        @purchased_history.address = params[:address]
        @purchased_history.phone_number = params[:phone_number]
        @purchased_history.email_address = params[:email_address]
        @purchased_history.shipping = 0
        @purchased_history.save
        params[:purchased_item].each do |item_id, item_count|
          @purchased_item = PurchasedItem.new
          @purchased_item.purchased_history_id = @purchased_history.id
          @purchased_item.item_id = item_id.to_i
          @purchased_item.item_count = item_count["item_count"].to_i
          @purchased_item.save
          session[:cart].delete(item_id)
        end
      end
    elsif params['payjp-token']
      render 'payjp'
    else
    end
  end

  def payjp
    render 'new'
  end

  # sessioncreate POST   /purchased_histories/sessioncreate 商品詳細画面のsubmit後
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

  # sessiondestroy GET    /purchased_histories/sessiondestroy/:id カート画面で商品削除ボタン
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
