class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    # カートで使用するSession確認
    if session[:cart] == nil
      session[:cart] = {}
    end
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])
    @tax_included = (BigDecimal(@item.item_price) * BigDecimal("1.08")).ceil
    @purchased_history = PurchasedHistory.new
    @purchased_item = PurchasedItem.new
  end

  # GET /items/new
  def new
    @item = Item.new
    # refileで画像を投稿できるようにしている
    @item.post_images.build
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
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
