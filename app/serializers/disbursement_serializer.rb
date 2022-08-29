# frozen_string_literal: true

class DisbursementSerializer < ActiveModel::Serializer
  attributes :id, :week, :amount

  belongs_to :merchant
end
