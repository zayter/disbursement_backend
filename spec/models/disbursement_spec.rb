# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Disbursement do
  describe 'validations' do
    subject { build(:disbursement) }

    it { is_expected.to validate_presence_of :amount }
    it { is_expected.to validate_presence_of :week }
    it { is_expected.to validate_presence_of :year }
  end

  describe 'associations' do
    it { is_expected.to belong_to :merchant }
  end
end
