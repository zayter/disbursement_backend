# frozen_string_literal: true

module Disbursement
  class Calculate < ApplicationService
    PERCENTAGE_LIST = {
      '<50' => 0.01,
      '>=50 <300' => 0.0095,
      '>=300' => 0.0085
    }.freeze

    def initialize(order)
      @amount = order.amount
    end

    def call
      return @amount * PERCENTAGE_LIST['<50'] if @amount < 50
      return @amount * PERCENTAGE_LIST['>=50 <300'] if @amount >= 50 && @amount < 300
      return @amount * PERCENTAGE_LIST['>=300'] if @amount >= 300
    end
  end
end
