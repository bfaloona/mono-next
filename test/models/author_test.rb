# frozen_string_literal: true

require_relative '../test_helper'
require_relative '../../config/database'
require_relative('../../app/models/author')

describe "Author Model" do
  it 'can construct a new instance' do
    @author = Author.new
    refute_nil @author
  end
end
