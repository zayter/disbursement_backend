# frozen_string_literal: true

# == Schema Information
#
# Table name: jwt_denylist
#
#  id  :bigint           not null, primary key
#  exp :datetime         not null
#  jti :string           not null
#
# Indexes
#
#  index_jwt_denylist_on_jti  (jti)
#
FactoryBot.define do
  factory :jwt_denylist do
    jti { 'MyString' }
  end
end
