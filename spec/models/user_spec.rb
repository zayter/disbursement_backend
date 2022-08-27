# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    subject(:user) { build(:user) }

    it { is_expected.to validate_presence_of :email }

    it do
      expect(user)
        .to validate_uniqueness_of(:email)
        .case_insensitive
        .with_message('This email is already taken. Please choose a different email.')
    end

    it 'validates email format', :aggregate_failures do
      expect(user).to allow_value('test@test.com').for(:email)
      expect(user).not_to allow_value('testteest.com').for(:email).with_message('is invalid')
    end
  end

  describe 'associations' do
    it { is_expected.to have_one(:shopper).dependent(:destroy) }
  end
end
