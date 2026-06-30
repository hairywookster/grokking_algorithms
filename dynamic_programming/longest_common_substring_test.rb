# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'longest_common_substring'

class LongestCommonSubstringTest < Minitest::Test

  def test_longest_common_substring_length_is_zero
    # skip
    assert_equal 0, DynamicProgrammingLongestCommonSubstring.length(nil, 'stuff')
    assert_equal 0, DynamicProgrammingLongestCommonSubstring.length('', 'stuff')
    assert_equal 0, DynamicProgrammingLongestCommonSubstring.length('stuff', nil)
    assert_equal 0, DynamicProgrammingLongestCommonSubstring.length('stuff', '')
    assert_equal 0, DynamicProgrammingLongestCommonSubstring.length('', '')
    assert_equal 0, DynamicProgrammingLongestCommonSubstring.length(nil, nil)
    assert_equal 0, DynamicProgrammingLongestCommonSubstring.length(nil, '')
    assert_equal 0, DynamicProgrammingLongestCommonSubstring.length('', nil)
  end

  def test_longest_common_substring_length_is_zero_for_words_with_no_overlap
    # skip
    assert_equal '', DynamicProgrammingLongestCommonSubstring.length('fish', 'zoo')
  end

  def test_longest_common_substring_length_for_similar_sounding_words_with_overlap
    # skip
    assert_equal 'ish', DynamicProgrammingLongestCommonSubstring.length('fish', 'hish')
  end

  def test_longest_common_substring_length_for_fake_words_with_multiple_common_substrings_of_different_sizes
    # skip
    # 'pigge' is longer than 'gelt'
    assert_equal 'pigge', DynamicProgrammingLongestCommonSubstring.length('higgeltypiggelty', 'nogeltitpiggenmud')
  end

  def test_longest_common_substring_length_for_different_sounding_words_with_overlap
    # skip
    assert_equal 'oli', DynamicProgrammingLongestCommonSubstring.length('foolish', 'police')
  end

  def test_longest_common_substring_length_for_words_with_single_letter_overlap
    # skip
    assert_equal 'u', DynamicProgrammingLongestCommonSubstring.length('bump', 'runner')
  end

end
