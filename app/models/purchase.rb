class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :product
  
  validates :quantity, presence: true, numericality: {only_integer: true, less_than: 5}
  validates :payment_method, presence: true,inclusion: {in: %w(代引き クレジットカード)}
end
