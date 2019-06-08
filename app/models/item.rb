class Item < ApplicationRecord
  # ==========================アソシエーション====================================
  has_many :post_images, dependent: :destroy
  has_one  :stock, dependent: :destroy
  # ===========================================================================

  # ============================gem要設定=======================================
  # refile用
  accepts_attachments_for :post_images, attachment: :image
  # ===========================================================================

end