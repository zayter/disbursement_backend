# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shopper do
  describe 'validations' do
    subject { build(:shopper) }

    it { is_expected.to validate_presence_of :nif }
    it { is_expected.to validate_uniqueness_of :nif }
  end

  describe 'associations' do
    it { is_expected.to belong_to :user }
  end
end
