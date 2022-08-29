# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DisbursementCollectJob do
  let!(:shopper) { create(:shopper) }
  let!(:merchant1) { create(:merchant) }
  let!(:merchant2) { create(:merchant) }

  let(:amount1) { 49.99 }
  let(:amount2) { 300 }

  before do
    create(:order, :completed_order, merchant: merchant1, shopper: shopper, amount: amount1)
    create(:order, :completed_order, merchant: merchant2, shopper: shopper, amount: amount2)
    Timecop.travel(1.week)
  end

  it 'queues the job' do
    expect { described_class.perform_later }
      .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it 'is in urgent queue' do
    expect(described_class.new.queue_name).to eq('collect')
  end

  it 'creates disbursements' do
    expect { described_class.perform_now }.to change(Disbursement, :count).by(2)
    expect(merchant1.disbursements.last.amount).to be > 0
    expect(merchant2.disbursements.last.amount).to be > 0
  end
end
