require 'rspec'
require 'spec_helper'
require 'master_grid_description_map'

describe MasterGridDescriptionMap do

  it 'should initialize with an enumerator and a count' do

    expect(MasterGridDescriptionMap.new([].each, 10)).to be
  end


  let(:six_appeals) do
    <<-EOS.split "\n"
    - Appeal to Anonymous Authority
    - Appeal to Authority
    - Appeal to Common Practice
    - Appeal to Ignorance
    - Appeal to Incredulity
    - Appeal to Money
    EOS
  end


  context "1x6" do
    subject {MasterGridDescriptionMap.new(six_appeals.each, 6)}
    it {should have_attributes(number_of_rows: 6, number_of_columns: 1)}
  end

  context "1x7" do
    subject {MasterGridDescriptionMap.new(six_appeals.each, 7)}
    it {should have_attributes(number_of_rows:6, number_of_columns:1)}
  end

  context "2x3" do
    subject {MasterGridDescriptionMap.new(six_appeals.each, 3)}
    it {should have_attributes(number_of_rows:3, number_of_columns:2)}
  end

  context "3x2" do
    subject {MasterGridDescriptionMap.new(six_appeals.each, 2)}
    it {should have_attributes(number_of_rows:2, number_of_columns:3)}
  end

  context "empty" do
    subject {MasterGridDescriptionMap.new([].each, 3)}
    it {should have_attributes(number_of_rows:0, number_of_columns:0)}
  end

  describe "#find_row_column" do
    subject {MasterGridDescriptionMap.new(six_appeals.each, 3)}
    it "does not find misspelled keyword" do
      expect(subject.find_row_column("apeale")).to be_nil
    end

    it "finds unique keyword" do
      expect(subject.find_row_column("Money")).to eq([2,1])
    end

    it "does not warn on unique keyword" do
      expect{subject.find_row_column("Money")}.to_not output.to_stderr
    end

    it "warns on non-unique keyword" do
      expect{subject.find_row_column("Appeal")}.to output.to_stderr
    end

    it "finds exact phrase" do
      expect(subject.find_row_column("Appeal to Common Practice")).to eq([2,0])
    end

    it "does case-insensitive search" do
      expect(subject.find_row_column("appeal to common practice")).to eq([2,0])
    end

    it "ignores extra spaces" do
      expect(subject.find_row_column("   Appeal  to  Common       Practice")).to eq([2,0])
    end
  end

end