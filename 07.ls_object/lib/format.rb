# frozen_string_literal: true

class Format
  COLUMN_COUNT = 4
  FIXED_SPACE_SIZE = 4

  def result(directory)
    contents = directory.long_option_files.map(&:file)
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
    puts items.transpose.join
  end
end
