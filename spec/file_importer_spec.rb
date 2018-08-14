require 'spec_helper'

describe FileImporter do

  let(:file_importer) {FileImporter.new('spec/fixtures/test_file.txt')}
  let(:json_file_importer) {FileImporter.new('spec/fixtures/json_test_file.txt')}


  it 'can open a file' do
    expect(file_importer.file).to_not be_nil
  end

  context 'reading lines' do

    it 'can read the first line of a file' do
      lines = file_importer.split_on_line
      expect(lines.first).to eq 'This is a test'
    end

    it 'can read the last line of a file' do
      lines = file_importer.split_on_line
      expect(lines.last).to eq 'This is a second test'
    end

  end

  context 'JSON' do
    it 'can read in JSON from a file and return a hash' do
      json_hash = json_file_importer.get_hash
      expect(json_hash['name']).to eq 'Homer Simpson'
      expect(json_hash['city']).to eq 'Springfield'
      expect(json_hash['state']).to eq 'Unknown'
      expect(json_hash['country']).to eq 'United States'
      expect(json_hash['family']).to match_array(["Marge", "Bart", "Lisa", "Maggie"])
      expect(json_hash['year']).to eq 1989
    end
  end

  context 'Remote JSON files' do
    it 'can get data from a remote json file' do
      json_hash = FileImporter.get_hash_from_link('http://mysafeinfo.com/api/data?list=englishmonarchs&format=json')
      expect(json_hash.count).to eq 57
    end
  end
end