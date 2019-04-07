class User < ApplicationRecord
  has_secure_password

  enum role: [:default, :merchant, :admin]

  validates_presence_of :name, :address, :city, :state, :zip
  validates :email, presence: true, uniqueness: true

  # as a consumer
  has_many :orders
  has_many :order_items, through: :orders

  # as a merchant
  has_many :items, foreign_key: 'merchant_id'
end