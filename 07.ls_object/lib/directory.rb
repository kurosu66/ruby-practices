# frozen_string_literal: true
require_relative 'file_info'

class Directory
  attr_reader :file_info

  def initialize(params)
    @file_info = fetch_file_info(params)
  end

  private

  def fetch_file_info(params)
    files = params['a'] ? Dir.entries('.').sort : Dir.glob('*')
    files = files.reverse if params['r']
    files.map { |file| FileInfo.new(file) }
  end
end
