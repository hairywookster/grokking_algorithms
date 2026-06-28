# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'travel_itinerary'

class TravelItineraryTest < Minitest::Test

  def test_empty_itinerary_if_no_attractions_given
    # skip
    nil_attractions = nil
    empty_attractions = {}
    days_available = 2
    attractions = [nil_attractions, empty_attractions]
    attractions.each do |available_attractions|
      result = DynamicProgrammingTravelItinerary.select(available_attractions, days_available)
      assert_empty result.attractions
    end
  end

  def test_itinerary_when_attractions_available_but_days_available_is_zero
    # skip
    abbey = AttractionItem.new(:westminster_abbey, 0.5, 7)
    available_attractions = [abbey]
    days_available = 0
    result = DynamicProgrammingTravelItinerary.select(available_attractions, days_available)
    assert_empty result.attractions
  end

  def test_itinerary_when_attractions_available_but_days_available_is_negative
    # skip
    abbey = AttractionItem.new(:westminster_abbey, 0.5, 7)
    available_attractions = [abbey]
    days_available = -55
    result = DynamicProgrammingTravelItinerary.select(available_attractions, days_available)
    assert_empty result.attractions
  end

  def test_itinerary_when_one_attraction_fits
    # skip
    abbey = AttractionItem.new(:abbey, 0.5, 7)
    available_attractions = [abbey]
    days_available = 2.5
    result = DynamicProgrammingTravelItinerary.select(available_attractions, days_available)
    assert_equal [abbey], result.attractions
    assert_equal '0.5/2.5', result.to_s
  end

  def test_itinerary_when_one_attraction_does_not_fit
    # skip
    abbey = AttractionItem.new(:abbey, 5, 7)
    available_attractions = [abbey]
    days_available = 2.5
    result = DynamicProgrammingTravelItinerary.select(available_attractions, days_available)
    assert_empty result.attractions
    assert_equal '0/2.5', result.to_s
  end


  def test_itinerary_when_attractions_available
    # skip
    abbey = AttractionItem.new(:abbey, 0.5, 7)
    globe = AttractionItem.new(:theater, 0.5, 6)
    gallery = AttractionItem.new(:gallery, 1, 9)
    museum = AttractionItem.new(:museum, 2, 9)
    cathedral = AttractionItem.new(:cathedral, 0.5, 8)

    available_attractions = [abbey, globe, gallery, museum, cathedral]

    days_available = 2
    result = DynamicProgrammingTravelItinerary.select(available_attractions, days_available)
    assert_equal [abbey, gallery, cathedral], result.attractions
    assert_equal '2.0/2', result.to_s
  end

  def test_itinerary_when_attractions_available_different_order
    # skip
    abbey = AttractionItem.new(:abbey, 0.5, 7)
    globe = AttractionItem.new(:theater, 0.5, 6)
    gallery = AttractionItem.new(:gallery, 1, 9)
    museum = AttractionItem.new(:museum, 2, 9)
    cathedral = AttractionItem.new(:cathedral, 0.5, 8)

    available_attractions = [museum, abbey, gallery, cathedral, globe]

    days_available = 2
    result = DynamicProgrammingTravelItinerary.select(available_attractions, days_available)
    assert_equal [abbey, gallery, cathedral], result.attractions
    assert_equal '2.0/2', result.to_s
  end

  def test_itinerary_when_attractions_available_different_days_available
    # skip
    abbey = AttractionItem.new(:abbey, 0.5, 7)
    globe = AttractionItem.new(:theater, 0.5, 6)
    gallery = AttractionItem.new(:gallery, 1, 9)
    museum = AttractionItem.new(:museum, 2, 9)
    cathedral = AttractionItem.new(:cathedral, 0.5, 8)

    available_attractions = [museum, abbey, gallery, cathedral, globe]

    days_available = 2.5
    result = DynamicProgrammingTravelItinerary.select(available_attractions, days_available)
    assert_equal [abbey, gallery, cathedral, globe], result.attractions
    assert_equal '2.5/2.5', result.to_s
  end
end
