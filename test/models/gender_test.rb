# frozen_string_literal: true

require_relative '../test_helper'
require_relative '../../config/database'
require_relative('../../app/models/gender')

describe "Gender Model" do
  it 'can construct a new instance' do
    @gender = Gender.new
    refute_nil @gender
  end
end
