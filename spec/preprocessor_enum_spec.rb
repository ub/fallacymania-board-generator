require 'rspec'
require 'preprocessor_enumerator'

describe PreprocessorEnumerator do
  it 'should be constructed from an enumerator [yielding strings]' do
    PreprocessorEnumerator.new(%w{one two three}.each)
  end

  subject { PreprocessorEnumerator.new(%w{one two three}.each) }
  it 'should work repeatedly' do
    expect(subject.entries).to eq(subject.entries)
  end

  context 'multi line ' do
    subject { PreprocessorEnumerator.new(%w{multi line content}.each)}
    it 'should be preserved' do
      expect(subject.entries).to eq(%w{multi line content})
    end
  end

  context 'empty line ' do
    subject { PreprocessorEnumerator.new([''].each) }
    it 'should be skipped' do
       expect(subject.entries).to eq([])
    end
  end

  context 'blank line ' do
    subject { PreprocessorEnumerator.new([" \n"].each) }
    it 'should be skipped' do
      expect(subject.entries).to eq([])
    end
  end

  context 'comment line' do
    subject { PreprocessorEnumerator.new([" ; some comment"].each) }
    it 'should be skipped' do
      expect(subject.entries).to eq([])
    end
  end

  context 'when mixed non-blank, blank and comment lines with content' do
    let(:example) {['', 'one', ' ', "two", ';', "three", "\n", "four", "; commented"] }
    subject { PreprocessorEnumerator.new(example.each) }
    let(:processed) {%w{one two three four}}
    it 'should leave content only' do
      expect(subject.entries).to eq(processed)
    end
  end

  context 'with real fixture file' do
    let(:file_io) {File.open(File.expand_path( "../fixtures/123.txt",__FILE__))}
    subject {PreprocessorEnumerator.new(file_io.each_line)}
    after(:all) {file_io.close}
    it 'should work' do
      expect(subject.entries.map(&:chomp)).to eq(%w{one two three})
    end
  end

end
