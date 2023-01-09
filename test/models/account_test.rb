# frozen_string_literal: true

require_relative '../test_helper'
require_relative '../../config/database'
require_relative('../../app/admin/models/account')

describe "Account Model" do
  it 'can construct a new instance' do
    @account = Account.new
    refute_nil @account
  end
end
