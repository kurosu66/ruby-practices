# frozen_string_literal: true

class FileInfo
  COLUMN_COUNT = 3
  FIXED_SPACE_SIZE = 4

  PERMISSION = {
    0 => '---',
    1 => '--x',
    2 => '-w-',
    3 => '-wx',
    4 => 'r--',
    5 => 'r-x',
    6 => 'rw-',
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

  def initialize(params, directory)
    @params = params
    @directory = directory
    @contents = fetch_contents
  end

  def fetch_contents
    current_dir_items = @directory.contents
  end

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
