# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id           :bigint           not null, primary key
#  aasm_state   :string           not null
#  amount       :float            not null
#  completed_at :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  merchant_id  :bigint           not null
#  shopper_id   :bigint           not null
#
# Indexes
#
#  index_orders_on_merchant_id  (merchant_id)
#  index_orders_on_shopper_id   (shopper_id)
#
FactoryBot.define do
  factory :order do
    merchant
    shopper
    amount { Faker::Number.decimal(l_digits: 2) }
    trait :completed_order do
      aasm_state { 'completed' }
      completed_at { Time.zone.now }
    end
  end
end
