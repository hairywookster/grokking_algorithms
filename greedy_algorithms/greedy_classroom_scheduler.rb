# frozen_string_literal: true

# A simple class to wrap a classes name, start and end time
class ScheduledClass
  attr_reader :name, :start_time, :end_time

  def initialize(name, start_time, end_time)
    @name = name
    @start_time = start_time
    @end_time = end_time
  end

  def to_s
    "#{@name} #{@start_time} - #{@end_time}"
  end

  def inspect
    @name
  end

end

# A simple greedy algorithm to schedule a series of classes based on start and end time.
module GreedyClassroomScheduler


  def self.maximize_schedule(class_list)
    # Defensive return empty schedule array if we do not have anything to process.
    return [] if class_list.nil? || class_list.empty?

    # duplicate the class list to avoid unintended changes
    classes_to_schedule = class_list.dup

    # Store the resulting schedule in an array
    schedule = []

    # repeat this process until we are done
    loop do
      # find the earliest finishing class
      class_ending_soonest = find_class_ending_soonest(classes_to_schedule)
      if class_ending_soonest
        # add it to the schedule
        schedule << class_ending_soonest

        #ignore any other classes starting before end time of the class we just scheduled
        delete_classes_starting_before_end_time(classes_to_schedule, class_ending_soonest.end_time)
      end
      # end our loop once we have scheduled everything
      break unless class_ending_soonest
    end

    # Return the schedule
    schedule
  end

  private_class_method def self.delete_classes_starting_before_end_time(classes_to_schedule, end_time)
    delete_these = []
    classes_to_schedule.each do |class_to_schedule|
      if class_to_schedule.start_time < end_time
        delete_these << class_to_schedule
      end
    end
    delete_these.each { |class_to_schedule| classes_to_schedule.delete(class_to_schedule) }
  end

  private_class_method def self.find_class_ending_soonest(classes_to_schedule)
    ending_earliest = nil
    classes_to_schedule.each do |class_to_schedule|
      if ending_earliest.nil? || class_to_schedule.end_time < ending_earliest.end_time
        # set this class as finishes earliest
        ending_earliest = class_to_schedule
      end
    end
    classes_to_schedule.delete(ending_earliest) unless ending_earliest.nil?
    ending_earliest
  end

end
