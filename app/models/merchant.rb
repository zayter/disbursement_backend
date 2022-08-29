# frozen_string_literal: true

# == Schema Information
#
# Table name: merchants
#
#  id         :bigint           not null, primary key
#  cif        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_merchants_on_cif      (cif) UNIQUE
#  index_merchants_on_user_id  (user_id)
#
class Merchant < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :destroy

  validates :cif, presence: true, uniqueness: true

  after_save :set_role

  scope :with_completed_orders, -> { joins(:orders).merge(Order.completed) }

  private

  def set_role
    user.roles << :merchant
    user.save
  end
end
