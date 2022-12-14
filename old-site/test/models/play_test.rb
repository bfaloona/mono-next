require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Play Model" do
  it 'can construct a new instance' do
    @play = Play.new
    refute_nil @play
  end
end
