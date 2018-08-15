require 'spec_helper'

describe FileImporter do

  let(:file) {'spec/fixtures/test_file.txt'}
  let(:json_file) {'spec/fixtures/json_test_file.txt'}
  let(:remote_json_file) {'http://mysafeinfo.com/api/data?list=englishmonarchs&format=json'}

  context 'reading lines' do

    it 'can read the first line of a file' do
      lines = FileImporter.split_on_line(file)
      expect(lines.first).to eq 'This is a test'
    end

    it 'can read the last line of a file' do
      lines = FileImporter.split_on_line(file)
      expect(lines.last).to eq 'This is a second test'
    end
    context 'Remote' do
      it 'can get the lines of a remote file' do
        lines = FileImporter.split_on_line_from_link(remote_json_file)
        expect(lines.count).to eq 344
      end
    end

  end

  context 'JSON' do
    it 'can read in JSON from a file and return a hash' do
      json_hash = FileImporter.get_hash(json_file)
      expect(json_hash['name']).to eq 'Homer Simpson'
      expect(json_hash['city']).to eq 'Springfield'
      expect(json_hash['state']).to eq 'Unknown'
      expect(json_hash['country']).to eq 'United States'
      expect(json_hash['family']).to match_array(["Marge", "Bart", "Lisa", "Maggie"])
      expect(json_hash['year']).to eq 1989
    end

    context 'Remote' do
      it 'can get data from a remote json file and return a hash' do
        json_hash = FileImporter.get_hash_from_link(remote_json_file)
        expect(json_hash.count).to eq 57
      end
    end

  end

end