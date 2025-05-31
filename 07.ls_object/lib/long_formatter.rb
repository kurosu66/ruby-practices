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
    total_block_size =  @directory.calculate_total_blocks(@current_dir_items)
    output(total_block_size)
  end

  private

  def output(total_block_size)
    puts "total #{total_block_size}"
    @current_dir_items.each do |v|
      puts "#{v.permission} #{v.nlink.to_s.rjust(FIXED_SPACE_SIZE)} #{v.owner} #{v.group} #{v.size.to_s.rjust(FIXED_SPACE_SIZE)} #{v.time_stamp} #{v.file_name}"
    end
  end
end
