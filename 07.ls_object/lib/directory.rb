class Directory
  attr_reader :contents

  def initialize(params)
    @contents = params['a'] ? Dir.entries('.').sort : Dir.glob('*')
  end
end
