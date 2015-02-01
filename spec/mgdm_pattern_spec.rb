require 'rspec'
require 'spec_helper'
require 'master_grid_description_map'

describe MasterGridDescriptionMap::Pattern do
  let(:phrase) {"Appeal to Consequences of a Belief"}
  let(:haystack) {[[phrase, 42, 69]]}

  it 'should compare phrase exactly' do
    expect(MasterGridDescriptionMap::Pattern.new(phrase) === [phrase]).to be_truthy
  end

  it 'should compare phrase case-insensitive' do
    expect(MasterGridDescriptionMap::Pattern.new("appeal to consequences of a belief") === [phrase]).to be_truthy
  end

  it 'should compare with extra spaces' do
    expect(MasterGridDescriptionMap::Pattern.new(" Appeal to    Consequences of a Belief ") === ["    Appeal to Consequences of a Belief "]).to be_truthy
  end

  it 'should not compare with typos' do
    expect(MasterGridDescriptionMap::Pattern.new("appeal to consequences of a believe") === [phrase]).to be_falsey
  end

end