require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Monologue Model" do
  it 'gender scope returns all without a parameter' do
    @monologues = Monologue.gender
    @monologues.length.must_equal 24
  end

  it 'matching and gender scopes can be combined' do
    @monologues = Monologue.gender(3).matching('z')
    @monologues.length.must_equal 4
  end

  it 'matching scope works' do
    @monologues = Monologue.matching('z')
    @monologues.length.must_equal 5
  end

end
