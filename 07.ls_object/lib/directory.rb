# frozen_string_literal: true

require_relative 'file_detail'

class Directory
  attr_reader :file_details

  def initialize(include_hidden_files, is_reverse)
    @file_details = fetch_file_details(include_hidden_files, is_reverse)
  end

  def adjust_max_length(files)
    max_length = files.max_by(&:length).length
    adjusted_max_length = max_length + ShortFormatter::FIXED_SPACE_SIZE
    files.map do |v|
      v + ' ' * (adjusted_max_length - v.length)
    end
  end

  def self.calculate_total_blocks(current_dir_items)
    current_dir_items.sum(&:lstat_blocks)
  end

  private

  def fetch_file_details(include_hidden_files, is_reverse)
    file_names = include_hidden_files ? Dir.entries('.').sort : Dir.glob('*')
    file_names = file_names.reverse if is_reverse
    file_names.map { |file_name| FileDetail.new(file_name) }
  end
end
