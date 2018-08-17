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
  context 'loops' do
    let(:array) { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] }
    it 'can loop over an array' do
      new_array = []
      array.each do |num|
        new_array << num
      end
      expect(new_array).to match_array(array)
    end

    it 'can get the even elements of an array' do
      new_array = []
      array.each_with_index do |num, index|
        if (index % 2) == 1
          new_array << num
        end
      end
      expect(new_array).to match_array([2, 4, 6, 8, 10])
    end

    it 'can get 2 elements per iteration' do
      new_array = []
      array.each_with_index do |num, index|
        if index * 2 >= array.count
          break
        end
        new_array << {first: array[index * 2], second: array[(index * 2) + 1]}
        index = index + 5
      end
      expect(new_array).to match_array([{first: 1, second: 2}, {first: 3, second: 4}, {first: 5, second: 6}, {first: 7, second: 8}, {first: 9, second: 10}])
    end
  end
end