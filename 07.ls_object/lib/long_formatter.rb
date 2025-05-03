# frozen_string_literal: true

require_relative '../lib/file_detail'

class LongFormatter 
  def result(directory)
    current_dir_items = directory.file_details
    long_option_contents = build_long_option_contents(current_dir_items)
    output(long_option_contents)
  end

  private

  def build_long_option_contents(current_dir_items)
    long_option_contents = {}
    long_option_contents[:total_block] = FileDetail.calculate_total_blocks(current_dir_items)
    long_option_contents[:files_long_option] = build_file_info_list(current_dir_items)
    long_option_contents
  end

  def build_file_info_list(current_dir_items)
    current_dir_items.map do |current_dir_item|
      {
        permission: current_dir_item.permission,
        n_link: current_dir_item.nlink.to_s.rjust(ShortFormatter::FIXED_SPACE_SIZE),
        owner: current_dir_item.owner,
        group: current_dir_item.group,
        size: current_dir_item.size.to_s.rjust(ShortFormatter::FIXED_SPACE_SIZE),
        time_stamp: current_dir_item.time_stamp,
        name: current_dir_item.file
      }
    end
  end

  def output(long_option_contents)
    puts "total #{long_option_contents[:total_block]}"
    long_option_contents[:files_long_option].each do |v|
      puts "#{v[:permission]} #{v[:n_link]} #{v[:owner]} #{v[:group]} #{v[:size]} #{v[:time_stamp]} #{v[:name]}"
    end
  end
end
