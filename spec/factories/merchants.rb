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
FactoryBot.define do
  factory :merchant do
    cif { Faker::Alphanumeric.alpha(number: 10) }

    after(:build) do |merchant|
      create(:user, merchant: merchant) if merchant.user.blank?
    end
  end
end
