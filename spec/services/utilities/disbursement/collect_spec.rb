# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Utilities::Disbursement::Collect do
  describe '#call' do
    subject(:call) { described_class.call(merchant.id, week, year) }

    let!(:shopper) { create(:shopper) }
    let!(:merchant) { create(:merchant) }
    let(:week) { Time.now.strftime('%W').to_i }
    let(:year) { Time.now.strftime('%Y').to_i }

    context 'when orders are complete' do
      let(:amount1) { 49.99 }
      let(:amount2) { 49.99 }
      let(:order1) { create(:order, merchant: merchant, shopper: shopper, amount: amount1) }
      let(:order2) { create(:order, merchant: merchant, shopper: shopper, amount: amount2) }

      before do
        order1.complete
        order1.save
        order2.complete
        order2.save
        Timecop.travel(1.week)
      end

      it 'returns a Float' do
        expect(call).to be_a(Float)
      end

      it 'calculates from completed orders' do
        expect(call).to eq(order1.disbursment + order2.disbursment)
      end
    end

    context 'when orders are pending' do
      let(:amount1) { 49.99 }
      let(:amount2) { 49.99 }
      let(:order1) { create(:order, merchant: merchant, shopper: shopper, amount: amount1) }
      let(:order2) { create(:order, merchant: merchant, shopper: shopper, amount: amount2) }

      before do
        Timecop.travel(1.week)
      end

      it 'returns a Zero' do
        expect(call).to eq(0)
      end
    end

    context 'when orders are mixed' do
      let(:amount1) { 300 }
      let(:amount2) { 70 }
      let(:amount3) { 60 }
      let(:order1) { create(:order, merchant: merchant, shopper: shopper, amount: amount1) }
      let(:order2) { create(:order, merchant: merchant, shopper: shopper, amount: amount2) }
      let(:order3) { create(:order, merchant: merchant, shopper: shopper, amount: amount3) }

      before do
        order1.complete
        order1.save
        order3.complete
        order3.save
        Timecop.travel(1.week)
      end

      it 'calculates from completed orders' do
        expect(call).to eq(order1.disbursment + order3.disbursment)
      end
    end

    context 'when collecting from beginning of year' do
      let(:amount1) { 300 }
      let(:amount2) { 70 }
      let(:order1) { create(:order, merchant: merchant, shopper: shopper, amount: amount1) }
      let(:order2) { create(:order, merchant: merchant, shopper: shopper, amount: amount2) }

      before do
        Timecop.travel(Time.now.getlocal.beginning_of_year.beginning_of_day - 1.week)
        order1.complete
        order1.save
        order2.complete
        order2.save
        Timecop.return
        Timecop.travel(Time.now.getlocal.beginning_of_year.beginning_of_day)
      end

      it 'calculates from completed orders' do
        expect(call).to eq(order1.disbursment + order2.disbursment)
      end
    end
  end
end
