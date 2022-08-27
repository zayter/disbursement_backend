# frozen_string_literal: true

# == Schema Information
#
# Table name: shoppers
#
#  id         :bigint           not null, primary key
#  nif        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_shoppers_on_nif      (nif) UNIQUE
#  index_shoppers_on_user_id  (user_id)
#
class Shopper < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :destroy

  validates :nif, presence: true, uniqueness: true

  after_save :set_role

  private

  def set_role
    user.roles << :shopper
    user.save
  end
end
