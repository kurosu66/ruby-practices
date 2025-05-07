# frozen_string_literal: true

require_relative 'file_detail'

class Directory
  attr_reader :file_details

  def initialize(command_line_option)
    @file_details = fetch_file_details(command_line_option)
  end

  def adjust_max_length(files)
    max_length = files.max_by(&:length).length
    adjusted_max_length = max_length + ShortFormatter::FIXED_SPACE_SIZE
    files.map do |v|
      v + ' ' * (adjusted_max_length - v.length)
    end
  end

  private

  def fetch_file_details(command_line_option)
    file_names = command_line_option['a'] ? Dir.entries('.').sort : Dir.glob('*')
    file_names = file_names.reverse if command_line_option['r']
    file_names.map { |file_name| FileDetail.new(file_name) }
  end
end
