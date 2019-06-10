class PurchasedItem < ApplicationRecord
  # ==========================アソシエーション====================================
  belongs_to :items
  belongs_to :purchased_history
  # ===========================================================================
end
