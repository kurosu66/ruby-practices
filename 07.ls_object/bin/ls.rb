#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
require 'date'
require_relative '../lib/directory'
require_relative '../lib/short_formatter'
require_relative '../lib/long_formatter'

command_line_option = ARGV.getopts('a', 'r', 'l')

include_hidden_files = command_line_option['a']
is_reverse = command_line_option['r']

directory = Directory.new(include_hidden_files, is_reverse)

lscommand = command_line_option['l'] ? LongFormatter.new : ShortFormatter.new
lscommand.result(directory)
