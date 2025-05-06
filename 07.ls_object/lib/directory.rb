# frozen_string_literal: true

require_relative 'file_detail'

class Directory
  attr_reader :file_details

  def initialize(command_line_option)
    @file_details = fetch_file_details(command_line_option)
  end

  def adjust_max_length(contents)
    max_length = contents.max_by(&:length).length
    adjusted_max_length = max_length + ShortFormatter::FIXED_SPACE_SIZE
    contents.map do |v|
      v + ' ' * (adjusted_max_length - v.length)
    end
  end

  private

  def fetch_file_details(command_line_option)
    files = command_line_option['a'] ? Dir.entries('.').sort : Dir.glob('*')
    files = files.reverse if command_line_option['r']
    files.map { |file| FileDetail.new(file) }
  end
end
