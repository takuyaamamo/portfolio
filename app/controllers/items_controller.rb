class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # items GET    /items トップページ
  def index
    # カートで使用するSession確認
    if session[:cart] == nil
      session[:cart] = {}
    else
      @cart = session[:cart].map { |item_id, item_count| Item.find(item_id.to_i) }
    end
    @items = Item.all
  end

  # item GET    /items/:id アイテムの詳細ページ
  def show
    @item = Item.find(params[:id])
    @tax_included = (BigDecimal(@item.item_price) * BigDecimal("1.08")).ceil
    @purchased_history = PurchasedHistory.new
    @purchased_item = PurchasedItem.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_history_params
      params.require(:purchase_history).permit(:user_name, :postal_code, :address, :phone_number, :email_address, :shipping, purchased_items_attributes: [:id, :purchased_history_id, :item_id, :item_count, :_destroy])
      # 複数画像を投稿できるように[]をつけている
      # フォームにhasoneのstockを含めている
    end
end
