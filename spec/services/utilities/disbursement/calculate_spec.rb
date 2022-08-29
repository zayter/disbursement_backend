# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Utilities::Disbursement::Calculate do
  describe '#call' do
    subject(:call) { described_class.call(order) }

    let(:order) { create(:order, amount: amount) }

    context 'when amount is less 50' do
      let(:amount) { 49.99 }

      it 'returns a Float' do
        expect(call).to be_a(Float)
      end

      it 'calculates 1%' do
        expect(call).to eq(0.4999)
      end
    end

    context 'when amount is 50' do
      let(:amount) { 50 }

      it 'returns a Float' do
        expect(call).to be_a(Float)
      end

      it 'calculates 0.095%' do
        expect(call).to eq(0.475)
      end
    end

    context 'when amount is greater than 50 but lesser 300' do
      let(:amount) { 299.99 }

      it 'returns a Float' do
        expect(call).to be_a(Float)
      end

      it 'calculates 0.095%' do
        expect(call).to eq(2.849905)
      end
    end

    context 'when amount is 300' do
      let(:amount) { 300 }

      it 'returns a Float' do
        expect(call).to be_a(Float)
      end

      it 'calculates 0.085%' do
        expect(call).to eq(2.5500000000000003)
      end
    end

    context 'when amount is greater than 300' do
      let(:amount) { 400 }

      it 'returns a Float' do
        expect(call).to be_a(Float)
      end

      it 'calculates 0.085%' do
        expect(call).to eq(3.4000000000000004)
      end
    end
  end
end
