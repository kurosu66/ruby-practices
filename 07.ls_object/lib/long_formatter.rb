# frozen_string_literal: true

require_relative '../lib/file_detail'

class LongFormatter 
  def result(directory)
    current_dir_items = directory.file_details
    total_block_size =  Directory.calculate_total_blocks(current_dir_items)
    detailed_files = build_detailed_files(current_dir_items)
    output(total_block_size, detailed_files)
  end

  private

  def fetch_detailed_files(current_dir_items)
    puts current_dir_items
  end

  def build_detailed_files(current_dir_items)
    current_dir_items.map do |current_dir_item|
      {
        permission: current_dir_item.permission,
        n_link: current_dir_item.nlink.to_s.rjust(ShortFormatter::FIXED_SPACE_SIZE),
        owner: current_dir_item.owner,
        group: current_dir_item.group,
        size: current_dir_item.size.to_s.rjust(ShortFormatter::FIXED_SPACE_SIZE),
        time_stamp: current_dir_item.time_stamp,
        name: current_dir_item.file_name
      }
    end
  end

  def output(total_block_size, detailed_files)
    puts "total #{total_block_size}"
    detailed_files.each do |v|
      puts "#{v[:permission]} #{v[:n_link]} #{v[:owner]} #{v[:group]} #{v[:size]} #{v[:time_stamp]} #{v[:name]}"
    end
  end
end
