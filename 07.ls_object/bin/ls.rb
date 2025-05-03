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

lscommand = command_line_option['l'] ? LongFormatter.new : ShortFormatter.new
lscommand.result(directory)
