class Stock < ApplicationRecord
  # ==========================アソシエーション====================================
  belongs_to  :item
  # ===========================================================================
end
