# frozen_string_literal: true

class DetailedFile 
  COLUMN_COUNT = 4
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

  attr_reader :file

  def initialize(file)
    @file = file
  end

  def fetch_lstat_blocks(file)
    File.lstat(file).blocks
  end

  def fetch_lstat
    lstat = File.lstat(file)
    {
      permission: fetch_permission_info(file),
      n_link: lstat.nlink.to_s.rjust(FileInfo::FIXED_SPACE_SIZE),
      owner: Etc.getpwuid(lstat.uid).name,
      group: Etc.getgrgid(lstat.gid).name,
      size: lstat.size.to_s.rjust(FileInfo::FIXED_SPACE_SIZE),
      time_stamp: fetch_time_stamp(lstat),
      name: file
    }
  end

  private

  def fetch_permission_info(file)
    stat = File.lstat(file)
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
