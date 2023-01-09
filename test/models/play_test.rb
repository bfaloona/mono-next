# frozen_string_literal: true

require_relative '../test_helper'
require_relative '../../config/database'
require_relative('../../app/models/play')

describe "Play Model" do
  it 'can construct a new instance' do
    @play = Play.new
    refute_nil @play
  end
end
