# frozen_string_literal: true

class Directory
  attr_reader :contents

  def initialize(params)
    @contents = params['a'] ? Dir.entries('.').sort : Dir.glob('*')
    @contents.reverse! if params['r']
  end
end
