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
FactoryBot.define do
  factory :shopper do
    nif { Faker::Alphanumeric.alpha(number: 10) }

    after(:build) do |shopper|
      create(:user, shopper: shopper) if shopper.user.blank?
    end
  end
end
