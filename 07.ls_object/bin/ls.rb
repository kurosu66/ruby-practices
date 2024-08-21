#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/lscommand'

params = ARGV.getopts('a', 'r', 'l')
lscommand = LsCommand.new(params)
puts lscommand.result

