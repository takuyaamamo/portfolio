class Admin::ItemsController < Admin::Base
  # 上記の < Admin::Baseでbase.rbを継承するように指示
  before_action :authenticate_admin!
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
    # refileで画像を投稿できるようにしている
    @item.post_images.build
    @item.item_description = "まねきねこはねこです。"
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
    @item.post_images.build
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
        format.js   { @status = "success"}
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
        format.js   { @status = "fail" }
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
        format.js   { @status = "success"}
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
        format.js   { @status = "fail" }
      end
    end
  end

  def statuschange
    item = Item.find(params[:id])
    if item.item_active == 0
      item.item_active = 1
      item.save
    else
      item.item_active = 0
      item.save
    end
    redirect_to admin_items_path
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
    def item_params
      params.require(:item).permit(:item_name, :item_description, :item_image_id, :item_qr, :item_price, :item_active, post_images_images: [])
      # 複数画像を投稿できるように[]をつけている
    end
end