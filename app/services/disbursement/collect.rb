# frozen_string_literal: true

module Disbursement
  class Collect < ApplicationService
    def initialize(merchant_id, week, year)
      @merchant_id = merchant_id
      @week = week
      @year = year
    end

    def call
      completed_orders.sum(&:disbursment)
    end

    private

    def completed_orders
      merchant.orders.completed_from_to(start_of_last_week, end_of_last_week)
    end

    def merchant
      @merchant ||= Merchant.find(@merchant_id)
    end

    def start_of_last_week
      @week += 1
      (Date.commercial(@year, @week, 1) - 8.days).beginning_of_week
    end

    def end_of_last_week
      start_of_last_week.end_of_week
    end
  end
end
