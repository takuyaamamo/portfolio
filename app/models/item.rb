class Item < ApplicationRecord
  # ==========================アソシエーション====================================
  has_many :post_images, dependent: :destroy
  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags
  has_many :purchased_items
  has_many :purchased_histories, through: :purchased_items
  has_one  :stock, dependent: :destroy
  # ===========================================================================

  # ============================gem要設定=======================================
  # refile用
  accepts_attachments_for :post_images, attachment: :image
  # ===========================================================================

  # ====================formにhasmanyをネストさせる===============================
  accepts_nested_attributes_for :stock, allow_destroy: true
  accepts_nested_attributes_for :item_tags, allow_destroy: true
  accepts_nested_attributes_for :tags, allow_destroy: true
  # ===========================================================================


end
