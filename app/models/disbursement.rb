# frozen_string_literal: true

# == Schema Information
#
# Table name: disbursements
#
#  id          :bigint           not null, primary key
#  amount      :float            not null
#  week        :integer          not null
#  year        :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  merchant_id :bigint           not null
#
# Indexes
#
#  index_disbursements_on_merchant_id  (merchant_id)
#
class Disbursement < ApplicationRecord
  belongs_to :merchant

  validates :amount, presence: true
  validates :week, presence: true
  validates :year, presence: true
end
