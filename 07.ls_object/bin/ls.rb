#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
require 'date'
require_relative '../lib/format'
require_relative '../lib/directory_contents'

params = ARGV.getopts('a', 'r', 'l')
directory_contents = Directory_Contents.new(params)
lscommand = Format.new(directory_contents, params)
if params["l"]
  puts lscommand.result["total_block"]
  lscommand.result["files_l_option"].each {|v| puts "#{v[:permission]} #{v[:n_link]} #{v[:owner]} #{v[:group]} #{v[:size]} #{v[:time_stamp]} #{v[:name]}"}
else
  lscommand.result.each {|v| puts v.join }
end
