# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Merchant do
  describe 'validations' do
    subject { build(:merchant) }

    it { is_expected.to validate_presence_of :cif }
    it { is_expected.to validate_uniqueness_of :cif }
  end

  describe 'associations' do
    it { is_expected.to belong_to :user }
  end
end
