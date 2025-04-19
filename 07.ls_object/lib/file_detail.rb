# frozen_string_literal: true

class FileDetail 
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

  attr_reader :file, :stat

  def initialize(file)
    @file = file
    @stat = File.lstat(file)
  end

  def lstat_blocks
    @stat.blocks
  end

  def permission
    file_stat_mode = @stat.mode.to_s(8)

    ftype = FILE_TYPE[@stat.ftype]
    permission_owner = PERMISSION[file_stat_mode[-3].to_i]
    permission_group = PERMISSION[file_stat_mode[-2].to_i]
    permission_user = PERMISSION[file_stat_mode[-1].to_i]

    "#{ftype}#{permission_owner}#{permission_group}#{permission_user}"
  end

  def time_stamp
    half_year_ago = Date.today.prev_month(6).to_time

    if @stat.mtime < half_year_ago
      @stat.mtime.strftime('%_b %e %_5Y')
    else
      @stat.mtime.strftime('%_b %e %H:%M')
    end
  end
end
