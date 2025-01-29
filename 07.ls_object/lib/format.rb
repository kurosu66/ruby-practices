# frozen_string_literal: true

class Format
  def initialize(directory)
    @directory = directory
  end

  def result(directory)
    contents = []
    contents += @directory.contents
    contents << ' ' until (contents.length % FileInfo::COLUMN_COUNT).zero?

    max_length = contents.max_by(&:length).length
    adjusted_max_length = max_length + FileInfo::FIXED_SPACE_SIZE
    items_with_spaces = contents.map do |v|
      v + ' ' * (adjusted_max_length - v.length)
    end

    items = []
    row = (contents.length / FileInfo::COLUMN_COUNT).ceil
    items_with_spaces.each_slice(row) do |c|
      items << c
    end
    items.transpose
  end
end
