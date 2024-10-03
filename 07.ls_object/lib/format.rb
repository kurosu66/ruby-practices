# frozen_string_literal: true

require_relative 'directory_contents'

class Format
  attr_reader :directory_contents, :params

  def initialize(directory_contents, params)
    @params = params
    @directory_contents = directory_contents
  end

  def result
    params['l'] ? contents : format(directory_contents)
  end

  def format(_directory_contents)
    contents << ' ' until (contents.length % DirectoryContents::COLUMN_COUNT).zero?

    max_length = contents.max_by(&:length).length
    adjusted_max_length = max_length + DirectoryContents::FIXED_SPACE_SIZE
    items_with_spaces = contents.map do |v|
      v + ' ' * (adjusted_max_length - v.length)
    end

    items = []
    row = (contents.length / DirectoryContents::COLUMN_COUNT).ceil
    items_with_spaces.each_slice(row) do |c|
      items << c
    end
    items.transpose
  end

  private

  def contents
    @directory_contents.contents
  end
end
