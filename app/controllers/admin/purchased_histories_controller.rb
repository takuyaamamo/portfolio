class Admin::PurchasedHistoriesController < Admin::Base
  before_action :set_purchased_history, only: [:show, :edit, :update, :destroy]

  # admin_purchased_histories GET    /admin/purchased_histories 注文履歴表示画面
  def index
    @purchased_histories = PurchasedHistory.all
  end

  # admin_purchased_history GET    /admin/purchased_histories/:id 注文履歴詳細表示
  def show
    @purchased_history = PurchasedHistory.find(params[:id])
    @purchased_items = PurchasedItem.where(purchased_history_id: @purchased_history.id)
  end

  # admin_shippingchange PUT    /admin/shippingchange/:id 注文のshipping変更
  def shippingchange
    @purchased_history = PurchasedHistory.find(params[:id])
    if @purchased_history.shipping == 0
      @purchased_history.shipping = 1
      @purchased_history.save
    else
      @purchased_history.shipping = 0
      @purchased_history.save
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchased_history
      @purchased_history = PurchasedHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchased_history_params
      params.require(:purchased_history).permit(:user_name, :postal_code, :address, :phone_number, :email_address, :shipping, :created_at, :updated_at)
    end
end
