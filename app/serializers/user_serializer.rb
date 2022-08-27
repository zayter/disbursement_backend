# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :roles, :email, :created_at

  has_one :shopper
  has_one :merchant
end
