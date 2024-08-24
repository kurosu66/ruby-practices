# frozen_string_literal: true

require 'optparse'
require_relative './format'





require 'debug' # todo 後で消す



class LsCommand
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def result
    current_dir_items = Dir.glob('*')

    if params['a']
      current_dir_items = []
      Dir.foreach('.') {|v| current_dir_items << v }
      current_dir_items.sort!
    end

    if params['r']
      current_dir_items = current_dir_items.reverse
    end

    format = Format.new(params)

    if params['l']
      format.format_l_option(current_dir_items)
    else
      format.format(current_dir_items, params)
    end
  end
end
