# frozen_string_literal: true

require_relative 'detailed_file'

class Directory
  attr_reader :detailed_files

  def initialize(command_line_option)
    @detailed_files = fetch_file_info(command_line_option)
  end

  private

  def fetch_file_info(command_line_option)
    files = command_line_option['a'] ? Dir.entries('.').sort : Dir.glob('*')
    files = files.reverse if command_line_option['r']
    files.map { |file| DetailedFile.new(file) }
  end
end
