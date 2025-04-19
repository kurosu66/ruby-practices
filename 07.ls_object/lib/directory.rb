# frozen_string_literal: true

require_relative 'file_detail'

class Directory
  attr_reader :file_details

  def initialize(command_line_option)
    @file_details = fetch_file_info(command_line_option)
  end

  private

  def fetch_file_info(command_line_option)
    files = command_line_option['a'] ? Dir.entries('.').sort : Dir.glob('*')
    files = files.reverse if command_line_option['r']
    files.map { |file| FileDetail.new(file) }
  end
end
