# frozen_string_literal: true

class FormatLongOption
  def result(directory)
    current_dir_items = directory.detailed_files

    long_option_contents = {}
    long_option_contents[:total_block] = current_dir_items.sum { |v| v.fetch_lstat_blocks(v.file) }
    long_option_contents[:files_long_option] = current_dir_items.map(&:fetch_lstat)

    puts "total #{long_option_contents[:total_block]}"
    long_option_contents[:files_long_option].each do |v|
      puts "#{v[:permission]} #{v[:n_link]} #{v[:owner]} #{v[:group]} #{v[:size]} #{v[:time_stamp]} #{v[:name]}"
    end
  end
end
