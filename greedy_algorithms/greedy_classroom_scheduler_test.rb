# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'greedy_classroom_scheduler'

class GreedyClassroomSchedulerTest < Minitest::Test

  def test_empty_schedule_if_no_classes_to_schedule
    # skip
    nil_classes = nil
    empty_classes = []
    classes = [nil_classes, empty_classes]
    classes.each do |class_list|
      result = GreedyClassroomScheduler.maximize_schedule(class_list)
      assert_empty result
    end
  end

  def create_schedulable_classes
    nine_am = Time.new(2026, 6, 6, 9, 0, 0)
    thirty_minutes = (30 * 60)
    one_hour = (60 * 60)
    nine_thirty = nine_am + thirty_minutes
    ten_am = nine_am + one_hour
    ten_thirty = ten_am + thirty_minutes
    eleven_am = ten_am + one_hour
    eleven_thirty = eleven_am + thirty_minutes
    twelve_am = eleven_am + one_hour

    pe = ScheduledClass.new('PE', nine_am, nine_thirty)
    latin = ScheduledClass.new('LATIN', ten_am, eleven_am)
    math = ScheduledClass.new('MATH', nine_thirty, ten_thirty)
    english = ScheduledClass.new('ENGLISH', nine_am, eleven_am)
    french = ScheduledClass.new('FRENCH', ten_thirty, eleven_am)
    divination = ScheduledClass.new('DIVINATION', nine_am, twelve_am)
    social = ScheduledClass.new('SOCIAL', eleven_am, twelve_am)
    potions = ScheduledClass.new('POTIONS', ten_thirty, twelve_am)
    dark_arts = ScheduledClass.new('DARK ARTS', eleven_thirty, twelve_am)

    [pe, latin, math, english, french, divination, social, potions, dark_arts]
  end

  def test_usable_schedule
    # skip
    class_list = create_schedulable_classes
    pe, math, french, social = class_list[0], class_list[2], class_list[4], class_list[6]
    result = GreedyClassroomScheduler.maximize_schedule(class_list)
    assert_equal [pe, math, french, social], result
  end

  def test_altered_order_gives_different_usable_schedule
    # skip
    class_list = create_schedulable_classes
    # bump dark arts up the list so it appears before social
    dark_arts = class_list[8]
    class_list.delete(dark_arts)
    class_list.insert(2,dark_arts)

    pe, math, french, social = class_list[0], class_list[3], class_list[5], class_list[2]
    result = GreedyClassroomScheduler.maximize_schedule(class_list)
    assert_equal [pe, math, french, social], result
  end

end
