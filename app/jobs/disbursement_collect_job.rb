# frozen_string_literal: true

class DisbursementCollectJob < ApplicationJob
  queue_as :collect

  def perform
    Merchant.with_completed_orders.each do |merchant|
      amount = Utilities::Disbursement::Collect.call(merchant.id, week, year)
      merchant.disbursements.find_or_initialize_by({ week: week, year: year }).update(amount: amount)
    end
  end

  private

  def week
    Time.now.strftime('%W').to_i
  end

  def year
    Time.now.strftime('%Y').to_i
  end
end
