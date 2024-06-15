# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_mark, second_mark, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def score
    if third_shot.mark == nil
      [first_shot.score, second_shot.score].sum
    else
      [first_shot.score, second_shot.score, third_shot.score].sum
    end
  end

  def is_spare
    [first_shot.score, second_shot.score].sum == 10 && first_shot.score <= 9
  end

  def is_strike
    first_shot.score == 10
  end
end
