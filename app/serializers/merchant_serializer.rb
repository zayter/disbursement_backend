# frozen_string_literal: true

class MerchantSerializer < ActiveModel::Serializer
  attributes :id, :cif, :created_at
end
