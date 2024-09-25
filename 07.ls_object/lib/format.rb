# frozen_string_literal: true

class Format
  attr_reader :directory_contents, :params

  def initialize(directory_contents, params)
    @params = params
    @directory_contents = directory_contents
  end

  def result
    params['l'] ? format_l_option(directory_contents) : format(directory_contents)
  end

  def format(directory_contents)
    contents << ' ' until (contents.length % COLUMN_COUNT).zero?

    max_length = contents.max_by(&:length).length
    adjusted_max_length = max_length + FIXED_SPACE_SIZE
    items_with_spaces = contents.map do |v|
      v + ' ' * (adjusted_max_length - v.length)
    end

    items = []
    row = (contents.length / COLUMN_COUNT).ceil
    items_with_spaces.each_slice(row) do |c|
      items << c
    end
    items.transpose
  end

  def format_l_option(directory_contents)
    contents
  end

  private

  def contents = @directory_contents.contents

end
