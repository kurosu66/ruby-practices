# frozen_string_literal: true

require 'optparse'
require 'etc'
require 'date'
require_relative './fileinfo'



require 'debug' # todo 後で消す



class Format
  attr_reader :directory_contents, :params, :contents

  def initialize(directory_contents, params)
    @params = params
    @directory_contents = directory_contents
    @contents = directory_contents.contents #ここがエラー。 2024/09/21
  end


  def result
    params['l'] ? format_l_option(directory_contents) : format(directory_contents)
  end

  def format(directory_contents)
    @contents << ' ' until (@contents.length % COLUMN_COUNT).zero?

    max_length = @contents.max_by(&:length).length
    adjusted_max_length = max_length + FIXED_SPACE_SIZE
    items_with_spaces = @contents.map do |v|
      v + ' ' * (adjusted_max_length - v.length)
    end

    items = []
    row = (@contents.length / COLUMN_COUNT).ceil
    items_with_spaces.each_slice(row) do |c|
      items << c
    end
    items.transpose
  end

  def format_l_option(directory_contents)

  end
end





  # ----------------------------------------
  # attr_reader :params

  # def initialize(params)
  #   @params = params
  # end

  # def format(current_dir_items)
  #   current_dir_items << ' ' until (current_dir_items.length % COLUMN_COUNT).zero?
  #
  #   max_length = current_dir_items.max_by(&:length).length
  #   adjusted_max_length = max_length + FIXED_SPACE_SIZE
  #   items_with_spaces = current_dir_items.map do |v|
  #     v + ' ' * (adjusted_max_length - v.length)
  #   end
  #
  #   items = []
  #   row = (current_dir_items.length / COLUMN_COUNT).ceil
  #   items_with_spaces.each_slice(row) do |c|
  #     items << c
  #   end
  #   items.transpose
  # end
  #
  #
  #
  # def format_l_option(current_dir_items) #このメソッドで取得と整形どっちもやっているので要リファクタ 2024/09/16
  #   total_block = current_dir_items.sum { |v| File.lstat(v).blocks }
  #
  #   files_l_option = current_dir_items.map do |current_dir_item|
  #     lstat = File.lstat(current_dir_item)
  #     {
  #       permission: format_permission(current_dir_item),
  #       n_link: lstat.nlink.to_s.rjust(FIXED_SPACE_SIZE),
  #       owner: Etc.getpwuid(lstat.uid).name,
  #       group: Etc.getgrgid(lstat.gid).name,
  #       size: File.lstat(current_dir_item).size.to_s.rjust(FIXED_SPACE_SIZE),
  #       time_stamp: format_time_stamp(lstat),
  #       name: File.basename(current_dir_item)
  #     }
  #   end
  #
  #   formatted_file_list = [] #二次元配列に入れる変数。冗長なので見直す必要あり
  #
  #   result = []
  #   result << "total #{total_block}\n"
  #
  #   files_l_option.each do |v|
  #     result << "#{v[:permission]}  #{v[:n_link]} #{v[:owner]}  #{v[:group]} #{v[:size]} #{v[:time_stamp]} #{v[:name]}\n"
  #   end
  #   formatted_file_list << result
  # end
  #
  # private
  #
  # def format_permission(current_dir_item)
  #   stat = File.lstat(current_dir_item)
  #   file_stat_mode = stat.mode.to_s(8)
  #
  #   ftype = FILE_TYPE[stat.ftype]
  #   permission_owner = PERMISSION[file_stat_mode[-3].to_i]
  #   permission_group = PERMISSION[file_stat_mode[-2].to_i]
  #   permission_user = PERMISSION[file_stat_mode[-1].to_i]
  #
  #   "#{ftype}#{permission_owner}#{permission_group}#{permission_user}"
  # end
  #
  # def format_time_stamp(lstat)
  #   half_year_ago = Date.today.prev_month(6).to_time
  #
  #   if lstat.mtime < half_year_ago
  #     lstat.mtime.strftime('%_b %e %_5Y')
  #   else
  #     lstat.mtime.strftime('%_b %e %H:%M')
  #   end
  # end
# end
