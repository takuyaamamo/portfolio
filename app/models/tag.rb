class Tag < ApplicationRecord
  # ==========================アソシエーション====================================
  has_many :item_tags
  has_many :items, through: :item_tags
  # ===========================================================================
end
