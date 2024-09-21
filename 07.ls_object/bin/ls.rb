#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/lscommand'
require_relative '../lib/directory_contents'

params = ARGV.getopts('a', 'r', 'l')
directory_contents = Directory_Contents.new(params)
lscommand = Format.new(directory_contents, params)
# lscommand = LsCommand.new(params)
lscommand.result.each {|v| puts v.join}


# クラス構成は以下にする
# 内容の取得クラス
# 整形クラス（スペース入れたり、rjust、transpose等）

# params = Argv.getopts('a',...)
# contennts = Contents.new(params)
# lscommand = display.new(contennts)
# lscommand.run
