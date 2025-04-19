# frozen_string_literal: true

class Format
  COLUMN_COUNT = 4
  FIXED_SPACE_SIZE = 4

  def result(directory)
    contents = directory.file_details.map(&:file)
    adjust_to_column_count(contents)
    items_with_spaces = adjust_max_length(contents)
    items = slice_items(contents, items_with_spaces)

    puts items.transpose.join
  end

  private

  def adjust_to_column_count(contents)
    contents << ' ' until (contents.length % COLUMN_COUNT).zero?
  end

  def adjust_max_length(contents)
    max_length = contents.max_by(&:length).length
    adjusted_max_length = max_length + FIXED_SPACE_SIZE
    contents.map do |v|
      v + ' ' * (adjusted_max_length - v.length)
    end
  end

  def slice_items(contents, items_with_spaces)
    row = (contents.length / COLUMN_COUNT).ceil
    items_with_spaces.each_slice(row).to_a
  end
end
