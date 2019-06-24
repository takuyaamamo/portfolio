class Admin::ItemsController < Admin::Base
  # 上記の < Admin::Baseでbase.rbを継承するように指示
  before_action :authenticate_admin!
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET admin_items GET    /admin/items 管理者画面のトップページ
  def index
    if params[:search].present?
      # Tagを検索しItemを取り出す
      tags = Tag.where('tag_name LIKE ?', "%#{params[:search]}%")
      # ユーザー名を検索しPurchasedHistoryを取り出す
      purchased_histories = PurchasedHistory.where('user_name LIKE ?', "%#{params[:search]}%")
      if tags.present?
        # タグが取り出せた場合
        item_tags_item_id = tags.map { |tag| ItemTag.find_by(id: tag.id).item_id }
        @items = item_tags_item_id.uniq.map { |item_id| Item.find_by(id: item_id) }
        # @searchedは次jsファイルの条件分岐用
        @searched = 'item'
      elsif purchased_histories.present?
        # ユーザー名が取り出せた場合
        @items_with_deleted = Item.with_deleted
        @purchased_histories = purchased_histories.order(created_at: "DESC")
        @searched = 'username'
      else
        # タグが見つからない場合通常表示
        @items = Item.all.order(created_at: "DESC")
        @items_with_deleted = Item.with_deleted
        @purchased_histories = PurchasedHistory.all.order(created_at: "DESC")
        @searched = 'all'
      end
    else
      # 通常表示
      @items = Item.all.order(created_at: "DESC")
      @items_with_deleted = Item.with_deleted
      @purchased_histories = PurchasedHistory.all.order(created_at: "DESC")
      @searched = 'all'
    end
  end

  # GET admin_item GET    /admin/items/:id アイテムのQRコード表示
  def show
    @item = Item.find(params[:id])
    # svgでqr生成
    @qr = RQRCode::QRCode.new(@item.item_qr).as_svg.html_safe
  end

  # new_admin_item GET    /admin/items/new アイテム新規登録フォーム表示
  def new
    @item = Item.new
    @tags = Tag.new
    # refileで画像を投稿できるようにしている
    @item.post_images.build
    @item.item_description = "まねきねこはねこです。"
    @item.build_stock
    # @item.tags.build
  end

  # admin_items POST   /admin/items アイテム新規登録フォームの登録
  def create
    # gem cocoonによりネストした増殖フォームは上手に保存してくれている
    @item = Item.new(item_params)
    @tag = Tag.new(tag_params)
    respond_to do |format|
      if @item.save
        # 一個目のタグ新規追加フォームは以下で制御
        if @tag.tag_name?
          # タグが空欄の場合保存しないようにする
          @tag.save
          ItemTag.create(item_id: @item.id, tag_id: @tag.id)
        end
        # QRコードのURLを生成
        @item.item_qr = "https://portfolio.amamo.site/#Item#{@item.id}"
        @item.save
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

  # edit_admin_item GET    /admin/items/:id/edit アイテムの編集ページ
  def edit
    @item = Item.find(params[:id])
    @tags = Tag.new
  end

  # admin_item PUT    /admin/items/:id アイテム編集登録
  def update
    # gem cocoonによりネストした増殖フォームは上手に保存してくれている
    @item = Item.find(params[:id])
    @tag = Tag.new(tag_params)
    respond_to do |format|

      if @item.update(item_params)
        # 一個目のタグ新規追加フォームは以下で制御
        if @tag.tag_name?
          # タグが空欄の場合保存しないようにする
          @tag.save
          ItemTag.create(item_id: @item.id, tag_id: @tag.id)
        end
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

  # admin_statuschange PUT    /admin/statuschange/:id item_active変更
  def statuschange
    @item = Item.find(params[:id])
    if @item.item_active == 0
      @item.item_active = 1
      @item.save
    else
      @item.item_active = 0
      @item.save
    end
  end

  # admin_confirm GET    /admin/confirm/:id 商品削除確認画面
  def confirm
    @item = Item.find(params[:id])
  end

  # admin_item DELETE /admin/items/:id 商品削除確認画面から商品の削除
  def destroy
    respond_to do |format|
      if @item.destroy
        format.html { redirect_to admin_items_path, notice: 'Item was successfully destroyed.' }
        format.json { head :no_content }
        format.js   { @status = "success"}
      else
        format.html { redirect_to admin_items_path, notice: 'Item was error destroyed.' }
        format.json { head :no_content }
        format.js   { @status = "fail" }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(
        :item_name, :item_description, :item_image_id, :item_qr, :item_price, :item_active,
        post_images_images: [],
        stock_attributes: [:id, :item_id, :stock_count],
        tags_attributes: [:id, :tag_name, :_destroy],
        tag_ids: [])
      # 複数画像を投稿できるように[]をつけている
      # フォームにhasoneのstockを含めている
    end

    def tag_params
      params.require(:tag).permit(:tag_name)
    end
end
