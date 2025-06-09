# frozen_string_literal: true

require_relative '../lib/file_detail'
require_relative './formatter_constants'

class LongFormatter
  include FormatterConstants

  def initialize(directory)
    @directory = directory
    @current_dir_items = @directory.file_details
  end

  def result
    puts "total #{@current_dir_items.sum(&:lstat_blocks)}"
    @current_dir_items.each do |v|
      puts "#{v.permission} #{v.nlink.to_s.rjust(FIXED_SPACE_SIZE)} #{v.owner} #{v.group} #{v.size.to_s.rjust(FIXED_SPACE_SIZE)} #{v.time_stamp} #{v.file_name}"
    end
  end
end
