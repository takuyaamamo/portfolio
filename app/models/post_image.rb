class PostImage < ApplicationRecord
  # =========================アソシエーション=====================================
  belongs_to :item
  # ===========================================================================
  
  # ============================gem要設定=======================================
  attachment :image
  # ===========================================================================

end
