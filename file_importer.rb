require 'json'
require 'open-uri'

class FileImporter

  attr_accessor :file

  def self.split_on_line(file_name)
    file = open_file(file_name)
    file.read.split("\n")
  end

  def self.split_on_line_from_link(url)
    file = open(url).read
    file.split("\n")
  end

  def self.get_hash(file_name)
    file = open_file(file_name)
    json_file = File.read(file)
    JSON.parse(json_file)
  end

  def self.get_hash_from_link(url)
    json_file = open(url).read
    JSON.parse(json_file)
  end

  private
  def self.open_file(file_name)
    path = File.join(File.dirname(__FILE__), file_name)
    File.open(path)
  end
end
