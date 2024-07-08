# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(marks)
    @frames = parse_marks(marks)
  end

  def score
    total_score = []
    @frames.each_with_index do |frame, i|
      if i == 9 && !@frames[i].nil?
        total_score << @frames[i].score
        break
      end

      if frame.strike?
        total_score << @frames[i + 1].first_shot.score
        total_score << if @frames[i + 1].second_shot.nil? # ストライクの次の次の投球がストライクの場合
                         @frames[i + 2].first_shot.score
                       else
                         @frames[i + 1].second_shot.score
                       end
      end

      total_score << @frames[i + 1].first_shot.score if frame.spare?

      total_score << frame.score
    end
    total_score.sum
  end

  private

  def parse_marks(marks)
    mark_pairs = insert_zero_after_x(marks).each_slice(2).to_a

    frames = []
    mark_pairs.each do |s|
      frames << if s == %w[X 0]
                  ['X']
                else
                  s
                end

      concat_last_frame(frames)
    end

    frames.map do |f|
      Frame.new(f[0], f[1], f[2])
    end
  end

  def concat_last_frame(frames)
    frames[9].concat(frames[10]) if frames[10]
    frames.slice!(10)
  end

  def insert_zero_after_x(marks)
    zeros_inserted_marks = []
    marks.split(',').each do |m|
      zeros_inserted_marks << m
      zeros_inserted_marks << '0' if m == 'X'
    end
    zeros_inserted_marks
  end
end
