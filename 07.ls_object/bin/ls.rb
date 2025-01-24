#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
require 'date'
require_relative '../lib/format'
require_relative '../lib/directory'
require_relative '../lib/file_info.rb'
require_relative '../lib/format_long_option.rb'

params = ARGV.getopts('a', 'r', 'l')
directory = Directory.new(params)
file_info = FileInfo.new(params, directory)

if params['l']
  lscommand_long_option = Format_long_option.new(file_info, params)
  lscommand_long_option.result.each { |v| puts "#{v[:permission]} #{v[:n_link]} #{v[:owner]} #{v[:group]} #{v[:size]} #{v[:time_stamp]} #{v[:name]}" }
else
  lscommand = Format.new(directory, params)
  lscommand.result(directory).each { |v| puts v.join }
end
