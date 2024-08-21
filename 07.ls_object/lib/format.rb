# frozen_string_literal: true

require 'optparse'




require 'debug'




class Format
  COLUMN_COUNT = 6
  FIXED_SPACE_SIZE = 4

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

  end
end
