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
    # 商品検索
    @items = if params[:search].present?
      # Tagを検索しItemを取り出す
      tags = Tag.where('tag_name LIKE ?', "%#{params[:search]}%")
      if tags.present?
        item_tags = tags.map { |tag| ItemTag.where(tag_id: tag.id) }
        @items = item_tags.flatten!.map { |item_tag| Item.find_by(id: item_tag.item_id) }.uniq
      else
        # タグが見つからない場合
        Item.all.order(created_at: "DESC")
      end
    else
      # 通常表示
      Item.all.order(created_at: "DESC")
    end
  end

  # item GET    /items/:id アイテムの詳細ページ
  def show
    @item = Item.find(params[:id])
    @tax_included = (BigDecimal(@item.item_price) * BigDecimal("1.08")).ceil
    @purchased_history = PurchasedHistory.new
    @purchased_item = PurchasedItem.new
  end

  def create
    # アップルペイ本番仕様の場合以下を利用
    # begin
    # payjp決済確定
    # Payjp.api_key = ENV['PAYJP_TEST_SECRET_KEY']
    # Payjp::Charge.create(
    #   :amount => "1000",
    #   :card => params['payjp-token'],
    #   :currency => 'jpy',
    # )
    # purchased_history_save
    # redirect_to root_path
    # rescue Payjp::CardError
    #   respond_to do |format|
    #     format.html { redirect_to root_path, notice: 'カードエラーが発生しました' }
    #   end
    # end
    redirect_to root_path
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
