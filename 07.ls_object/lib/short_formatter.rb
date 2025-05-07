# frozen_string_literal: true

class ShortFormatter
  COLUMN_COUNT = 4
  FIXED_SPACE_SIZE = 4

  def result(directory)
    files = directory.file_details.map(&:file_name)
    adjust_to_column_count(files)
    items_with_spaces = directory.adjust_max_length(files)
    items = slice_items(files, items_with_spaces)

    puts items.transpose.join
  end

  private

  def adjust_to_column_count(files)
    files << ' ' until (files.length % COLUMN_COUNT).zero?
  end

  def slice_items(files, items_with_spaces)
    row = (files.length / COLUMN_COUNT).ceil
    items_with_spaces.each_slice(row).to_a
  end
end
