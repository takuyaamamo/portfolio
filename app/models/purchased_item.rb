class PurchasedItem < ApplicationRecord
  # ==========================アソシエーション====================================
  belongs_to :items, optional: true
  belongs_to :purchased_history, optional: true
  # ===========================================================================
end
