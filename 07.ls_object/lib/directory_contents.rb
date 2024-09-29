# frozen_string_literal: true

require 'debug'

class DirectoryContents
  COLUMN_COUNT = 7
  FIXED_SPACE_SIZE = 4

  PERMISSION = {
    0 => '---',
    1 => '--x',
    2 => '-w-',
    3 => '-wx',
    4 => 'r--',
    5 => 'r-x',
    6 => 'rx-',
    7 => 'rwx'
  }.freeze

  FILE_TYPE = {
    'fifo' => 'p',
    'characterSpecial' => 'c',
    'directory' => 'd',
    'blockSpecial' => 'b',
    'file' => '-',
    'link' => 'l',
    'socket' => 's'
  }.freeze

  attr_reader :params, :contents

  def initialize(params)
    @params = params
    @contents = fetch_contents
  end

  def fetch_contents
    current_dir_items = params['a'] ? Dir.entries('.') : Dir.glob('*')

    current_dir_items.reverse! if params['r']

    if params['l']
      l_option_contents = {}
      l_option_contents["total_block"] = current_dir_items.sum { |v| File.lstat(v).blocks }
      l_option_contents["files_l_option"] = current_dir_items.map do |current_dir_item|
            lstat = File.lstat(current_dir_item)
            {
              permission: fetch_permission_info(current_dir_item),
              n_link: lstat.nlink.to_s.rjust(FIXED_SPACE_SIZE),
              owner: Etc.getpwuid(lstat.uid).name,
              group: Etc.getgrgid(lstat.gid).name,
              size: File.lstat(current_dir_item).size.to_s.rjust(FIXED_SPACE_SIZE),
              time_stamp: fetch_time_stamp(lstat),
              name: File.basename(current_dir_item)
            }
      end
      return l_option_contents
    end
    current_dir_items
  end

  private

  def fetch_permission_info(current_dir_item)
    stat = File.lstat(current_dir_item)
    file_stat_mode = stat.mode.to_s(8)

    ftype = FILE_TYPE[stat.ftype]
    permission_owner = PERMISSION[file_stat_mode[-3].to_i]
    permission_group = PERMISSION[file_stat_mode[-2].to_i]
    permission_user = PERMISSION[file_stat_mode[-1].to_i]

    "#{ftype}#{permission_owner}#{permission_group}#{permission_user}"
  end

  def fetch_time_stamp(lstat)
    half_year_ago = Date.today.prev_month(6).to_time

    if lstat.mtime < half_year_ago
      lstat.mtime.strftime('%_b %e %_5Y')
    else
      lstat.mtime.strftime('%_b %e %H:%M')
    end
  end
end
