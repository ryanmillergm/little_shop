class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  validates_presence_of :status

  enum status: [:pending, :packaged, :shipped, :cancelled]

  def total_item_count
    order_items.sum(:quantity)
  end

  def total_cost
    oi = order_items.pluck("sum(quantity * price)")
    oi.sum
  end

  def self.pending_orders_for_merchant(merchant_id)
    self.joins(:items)
        .where(status: :pending)
        .where(items: {merchant_id: merchant_id})
        .distinct
  end

  def total_quantity_for_merchant(merchant_id)
    items.joins(:order_items)
         .select('items.id, order_items.quantity')
         .where(items: {merchant_id: merchant_id})
         .distinct
         .sum('order_items.quantity')
  end

  def total_price_for_merchant(merchant_id)
    items.joins(:order_items)
         .where(items: {merchant_id: merchant_id})
         .select('items.id, order_items.quantity, order_items.price')
         .distinct
         .sum('order_items.quantity * order_items.price')
  end
end
