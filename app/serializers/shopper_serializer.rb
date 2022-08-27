# frozen_string_literal: true

class ShopperSerializer < ActiveModel::Serializer
  attributes :id, :nif, :created_at
end
