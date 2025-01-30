# frozen_string_literal: true

class FormatLongOption
  def initialize(directory, file_info)
    @directory = directory
    @file_info = file_info
  end

  def result
    current_dir_items = @directory.contents

    l_option_contents = {}
    l_option_contents['total_block'] = current_dir_items.sum { |v| File.lstat(v).blocks }
    l_option_contents['files_l_option'] = current_dir_items.map do |current_dir_item|
      lstat = File.lstat(current_dir_item)
      {
        permission: @file_info.fetch_permission_info(current_dir_item),
        n_link: lstat.nlink.to_s.rjust(FileInfo::FIXED_SPACE_SIZE),
        owner: Etc.getpwuid(lstat.uid).name,
        group: Etc.getgrgid(lstat.gid).name,
        size: File.lstat(current_dir_item).size.to_s.rjust(FileInfo::FIXED_SPACE_SIZE),
        time_stamp: @file_info.fetch_time_stamp(lstat),
        name: File.basename(current_dir_item)
      }
    end
    l_option_contents
  end
end
