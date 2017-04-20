class Order < ApplicationRecord
  belongs_to :user
  has_many :order_creatures
  has_many :creatures, through: :order_creatures
  validates :total, presence: true
  validates :status, presence: true

  enum status: %w(ordered paid cancelled completed)

  def creation_date
    created_at.strftime('%b %e, %l:%M %p')
  end

  def total_price
    order_creatures.reduce(0) do |sum, oc|
      sum += oc.quantity * Creature.find(oc.creature_id).price
    end
  end
end
