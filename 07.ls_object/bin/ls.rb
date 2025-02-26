#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
require 'date'
require_relative '../lib/directory'
require_relative '../lib/format'
require_relative '../lib/format_long_option'
require_relative '../lib/command_line_option'


command_line_option = CommandLineOption.new().params
directory = Directory.new(command_line_option)

if command_line_option['l']
  ls_command_long_option = FormatLongOption.new()
  result = ls_command_long_option.result(directory)

  puts "total #{ result[:total_block] }"
  result[:files_l_option].each do |v|
    puts "#{v[:permission]} #{v[:n_link]} #{v[:owner]} #{v[:group]} #{v[:size]} #{v[:time_stamp]} #{v[:name]}"
  end
else
  ls_command = Format.new()
  result = ls_command.result(directory)
  puts result.join
end
