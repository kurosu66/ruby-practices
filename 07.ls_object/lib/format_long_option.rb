# frozen_string_literal: true

class FormatLongOption
  def result(directory)
    current_dir_items = directory.file_info

    l_option_contents = {}
    l_option_contents[:total_block] = current_dir_items.sum { |v| v.fetch_lstat_blocks(v.file) }
    l_option_contents[:files_l_option] = current_dir_items.map do |current_dir_item|
      current_dir_item.fetch_lstat
    end
    l_option_contents
  end
end
