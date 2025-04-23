# frozen_string_literal: true

require_relative '../lib/file_detail'

class FormatLongOption
  def result(directory)
    current_dir_items = directory.file_details
    long_option_contents = {}
    long_option_contents = build_long_option_contents(current_dir_items)
    output(long_option_contents)
  end

  private

  def build_long_option_contents(current_dir_items)
    long_option_contents = {}
    long_option_contents[:total_block] = FileDetail.calculate_total_blocks(current_dir_items)
    long_option_contents[:files_long_option] = FileDetail.build_file_info_list(current_dir_items)
    long_option_contents
  end

  def output(long_option_contents)
    puts "total #{long_option_contents[:total_block]}"
    long_option_contents[:files_long_option].each do |v|
      puts "#{v[:permission]} #{v[:n_link]} #{v[:owner]} #{v[:group]} #{v[:size]} #{v[:time_stamp]} #{v[:name]}"
    end
  end
end
