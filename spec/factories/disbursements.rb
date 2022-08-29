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
  factory :disbursement do
    amount { Faker::Number.decimal(l_digits: 2) }
    week { 1 }
    year { Time.now.strftime('%Y').to_i }

    after(:build) do |disbursement|
      create(:merchant, disbursements: [disbursement]) if disbursement.merchant.blank?
    end
  end
end
