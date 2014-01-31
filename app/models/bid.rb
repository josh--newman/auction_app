class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  default_scope -> { order("created_at DESC") }

  validates :amount,  presence: true, numericality: true
  validates :user_id, presence: true
  validates :item_id, presence: true
end
