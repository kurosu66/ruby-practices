#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
require 'date'
require_relative '../lib/directory'
require_relative '../lib/short_formatter'
require_relative '../lib/long_formatter'

command_line_option = ARGV.getopts('a', 'r', 'l')
directory = Directory.new(command_line_option)

if command_line_option['l']
  ls_command_long_option = LongFormatter.new
  ls_command_long_option.result(directory)
else
  ls_command = ShortFormatter.new
  ls_command.result(directory)
end
