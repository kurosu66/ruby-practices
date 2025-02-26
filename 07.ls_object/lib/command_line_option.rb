# frozen_string_literal: true

class CommandLineOption
  attr_reader :params

  def initialize
    @params = ARGV.getopts('a', 'r', 'l')
  end
end
