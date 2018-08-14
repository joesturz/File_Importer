require 'json'
require 'open-uri'

class FileImporter

  attr_accessor :file
  
  def initialize(file_name)
    @path = File.join(File.dirname(__FILE__), file_name)
    @file = File.open(@path)
  end

  def split_on_line
    @file.read.split("\n")
  end

  def get_hash
    json_file = File.read(@path)
    JSON.parse(json_file)
  end

  def self.get_hash_from_link(url)
    json_file = open(url).read
    JSON.parse(json_file)
  end

end
