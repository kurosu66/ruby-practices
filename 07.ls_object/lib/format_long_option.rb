# frozen_string_literal: true

require_relative '../lib/long_option_file'

class FormatLongOption
  def result(directory)
    current_dir_items = directory.long_option_files
    long_option_contents = {}
    build_long_option_contents(current_dir_items, long_option_contents)

    puts "total #{long_option_contents[:total_block]}"
    long_option_contents[:files_long_option].each do |v|
      puts "#{v[:permission]} #{v[:n_link]} #{v[:owner]} #{v[:group]} #{v[:size]} #{v[:time_stamp]} #{v[:name]}"
    end
  end

  private

  def build_long_option_contents(current_dir_items, long_option_contents)
    long_option_contents[:total_block] = current_dir_items.sum { |v| v.lstat_blocks }
    long_option_contents[:files_long_option] = current_dir_items.map do |current_dir_item|
      lstat = current_dir_item.stat
      {
        permission: current_dir_item.permission,
        n_link: lstat.nlink.to_s.rjust(Format::FIXED_SPACE_SIZE),
        owner: Etc.getpwuid(lstat.uid).name,
        group: Etc.getgrgid(lstat.gid).name,
        size: lstat.size.to_s.rjust(Format::FIXED_SPACE_SIZE),
        time_stamp: current_dir_item.time_stamp,
        name: current_dir_item.file
      }
    end
  end
end
