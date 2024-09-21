# frozen_string_literal: true

require 'optparse'
require_relative './format'
require_relative './fileinfo'





require 'debug' # todo 後で消す



class LsCommand
  attr_reader :params
  attr_reader :current_dir_items

  def initialize(params)
    @params = params
    @current_dir_items = fetch_items
  end

  def fetch_items
    current_dir_items = []

    if params['a']
      Dir.foreach('.') {|v| current_dir_items << v }
      current_dir_items.sort!
    end

    if current_dir_items.empty?
     current_dir_items = Dir.glob('*')
    end

    if params['r']
      current_dir_items.reverse!
    end

    current_dir_items
  end

  def result
    formatter = Format.new(@params)
    @params['l'] ? formatter.format_l_option(@current_dir_items) : formatter.format(@current_dir_items)
  end
end
