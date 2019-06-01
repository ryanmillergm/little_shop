class Address < ApplicationRecord
  belongs_to :user
  belongs_to :order

  validates_presence_of :nickname, :address, :city, :state, :zip, :primary
end
