# frozen_string_literal: true

require_relative 'frame'



require 'debug'

class Game
  attr_reader :frames

  def initialize(marks)
    @frames = parse_marks(marks)
  end

  def parse_marks(marks)
    zeros_inserted_marks = insert_zero_after_x(marks)

    sliced_marks = []
    zeros_inserted_marks.each_slice(2) do |s|
      sliced_marks << s
    end

    framed_marks = []
    sliced_marks.each do |s|
      if s == %w[X 0]
        framed_marks << ["X"]
      else
        framed_marks << s
      end

      framed_marks[9].concat(framed_marks[10]) if framed_marks[10]
      framed_marks.slice!(10)
    end

    if framed_marks[9].length >= 4
      framed_marks[9] = framed_marks[9].reject { |item| item == "0" }
    end

    framed_marks.map do |f|
      Frame.new(f[0], f[1], f[2])
    end
  end

  def insert_zero_after_x(marks)
    zeros_inserted_marks = []
    marks.split(',').each do |m|
      zeros_inserted_marks << m
      zeros_inserted_marks << '0' if m == 'X'
    end
    zeros_inserted_marks
  end

  def score
    total_score = []
    frames.each_with_index do |f, i|
      if i == 9 && frames[i] != nil
        total_score << frames[i].score
        break
      end

      if f.is_strike
        total_score << frames[i + 1].first_shot.score
        if frames[i + 1].second_shot.mark.nil? # ストライクの次の次の投球がストライクの場合
          total_score << frames[i + 2].first_shot.score
        else
          total_score << frames[i + 1].second_shot.score
        end
      end

      if f.is_spare
        total_score << frames[i + 1].first_shot.score
      end

      total_score << f.score
    end
    total_score.sum
  end
end

game = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5') #139
puts game.score
