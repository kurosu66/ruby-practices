# frozen_string_literal: true

require 'optparse'
require 'etc'
require 'date'



require 'debug'




class Format
  COLUMN_COUNT = 6
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

  attr_reader :current_dir_items, :params

  def initialize(params)
    @params = params
  end

  def format(current_dir_items, params = nil)
    current_dir_items << ' ' until (current_dir_items.size % COLUMN_COUNT).zero?

    row = (current_dir_items.size / COLUMN_COUNT).ceil

    max_space_size = current_dir_items.max_by(&:length).length + FIXED_SPACE_SIZE

    space_added_items = current_dir_items.map do |items|
      each_space_size = max_space_size - items.size
      items + ' ' * each_space_size
    end

    result = space_added_items.each_slice(row).to_a.transpose.map do |v|
      v.join
    end
  end

  def format_l_option(current_dir_items)
    total_block = current_dir_items.sum { |v| File.lstat(v).blocks }

    files_l_option =
      current_dir_items.map do |current_dir_item|
        lstat = File.lstat(current_dir_item)
        {
          permission: format_permission(current_dir_item),
          n_link: lstat.nlink.to_s.rjust(3),
          owner: Etc.getpwuid(lstat.uid).name,
          group: Etc.getgrgid(lstat.gid).name,
          size: File.lstat(current_dir_item).size.to_s.rjust(5),
          time_stamp: format_time_stamp(lstat),
          name: File.basename(current_dir_item)
        }
      end

    display_l_option(total_block, files_l_option)
  end

  def format_permission(current_dir_item)
    stat = File.lstat(current_dir_item)
    file_stat_mode = stat.mode.to_s(8)

    ftype = FILE_TYPE[stat.ftype]
    permission_owner = PERMISSION[file_stat_mode[-3].to_i]
    permission_group = PERMISSION[file_stat_mode[-2].to_i]
    permission_user = PERMISSION[file_stat_mode[-1].to_i]

    "#{ftype}#{permission_owner}#{permission_group}#{permission_user}"
  end

  def format_time_stamp(lstat)
    half_year_ago = Date.today.prev_month(6).to_time

    if lstat.mtime < half_year_ago
      lstat.mtime.strftime('%_b %e %_5Y')
    else
      lstat.mtime.strftime('%_b %e %H:%M')
    end
  end

  def display_l_option(total_block, files_l_option)
    result = []
    result << "total #{total_block}"

    files_l_option.each do |v|
      result << "#{v[:permission]}  #{v[:n_link]} #{v[:owner]}  #{v[:group]} #{v[:size]} #{v[:time_stamp]} #{v[:name]}"
    end
    result
  end
end
