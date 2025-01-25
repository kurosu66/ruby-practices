# frozen_string_literal: true

class FormatLongOption
  attr_reader :result

  def initialize(file_info, params)
    @file_info = file_info
    @params = params
    @result = result 
  end

  def result
    @file_info.contents
  end
end
