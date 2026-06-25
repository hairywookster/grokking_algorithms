# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'greedy_set_cover'

class GreedySetCoverTest < Minitest::Test

  def test_empty_coverage_when_no_sets_given
    # skip
    nil_sets = nil
    empty_sets = {}
    sets = [nil_sets, empty_sets]
    sets.each do |available_sets|
      result = GreedySetCover.cover(available_sets)
      assert_empty result
    end
  end


  def test_full_coverage
    # skip
    available_stations = {
      radio1: Set.new([ :ID, :NV, :UT ]),
      radio2: Set.new([ :WA, :ID, :MT ]),
      radio3: Set.new([ :OR, :NV, :CA ]),
      radio4: Set.new([ :NV, :UT ]),
      radio5: Set.new([ :CA, :AZ ]),
      radio6: Set.new([ :BZ, :NV, :UT, :ZZ ]),
    }
    result = GreedySetCover.cover(available_stations)
    assert_equal [:radio6, :radio2, :radio3, :radio5], result
  end

  def test_full_coverage_different_order
    # skip
    available_stations = {
      radio5: Set.new([ :CA, :AZ ]),
      radio1: Set.new([ :ID, :NV, :UT ]),
      radio6: Set.new([ :BZ, :NV, :UT, :ZZ ]),
      radio3: Set.new([ :OR, :NV, :CA ]),
      radio2: Set.new([ :WA, :ID, :MT ]),
      radio4: Set.new([ :NV, :UT ]),
    }
    result = GreedySetCover.cover(available_stations)
    assert_equal [:radio6, :radio2, :radio5, :radio3], result
  end

  def test_full_coverage_similar_set_order
    # skip
    available_stations = {
      radio5: Set.new([ :CA, :AZ ]),
      radio1: Set.new([ :ID, :NV, :UT ]),
      radio0: Set.new([ :WA, :ID, :MT ]),   #this duplicates the other set but appears first so should be used before radio2
      radio6: Set.new([ :BZ, :NV, :UT, :ZZ ]),
      radio3: Set.new([ :OR, :NV, :CA ]),
      radio2: Set.new([ :WA, :ID, :MT ]),
      radio4: Set.new([ :NV, :UT ]),
    }
    result = GreedySetCover.cover(available_stations)
    assert_equal [:radio6, :radio0, :radio5, :radio3], result
  end
end