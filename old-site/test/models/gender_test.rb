require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Gender Model" do
  it 'can construct a new instance' do
    @gender = Gender.new
    refute_nil @gender
  end
end
