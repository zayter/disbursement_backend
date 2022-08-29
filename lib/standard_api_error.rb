# frozen_string_literal: true

class StandardAPIError < StandardError
  attr_reader :msg, :errors

  def initialize(msg = 'An error has occurred during the request', errors = [])
    @errors = errors
    super(msg)
  end
end
