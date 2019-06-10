class PurchasedHistory < ApplicationRecord
  # ==========================アソシエーション====================================
  has_many :purchased_items, dependent: :destroy
  has_many :items, through: :purchased_items
  # ===========================================================================
  # ====================formにhasmanyをネストさせる===============================
  accepts_nested_attributes_for :purchased_items, allow_destroy: true
  # ===========================================================================
end
