# frozen_string_literal: true

require_relative 'long_option_file'

class Directory
  attr_reader :long_option_files

  def initialize(command_line_option)
    @long_option_files = fetch_file_info(command_line_option)
  end

  private

  def fetch_file_info(command_line_option)
    files = command_line_option['a'] ? Dir.entries('.').sort : Dir.glob('*')
    files = files.reverse if command_line_option['r']
    files.map { |file| LongOptionFile.new(file) }
  end
end
