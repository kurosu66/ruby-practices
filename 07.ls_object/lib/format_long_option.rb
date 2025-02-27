# frozen_string_literal: true

class FormatLongOption
  def result(directory)
    current_dir_items = directory.file_info

    long_option_contents = {}
    long_option_contents[:total_block] = current_dir_items.sum { |v| v.fetch_lstat_blocks(v.file) }
    long_option_contents[:files_long_option] = current_dir_items.map(&:fetch_lstat)
    long_option_contents
  end
end
