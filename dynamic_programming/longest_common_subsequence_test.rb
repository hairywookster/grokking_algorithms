# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'longest_common_subsequence'

class LongestCommonSubsequenceTest < Minitest::Test

  def test_longest_common_subsequence_length_is_zero
    # skip
    assert_nil DynamicProgrammingLongestCommonSubsequence.find_longest_common_subsequence(nil, 'stuff')
    assert_nil DynamicProgrammingLongestCommonSubsequence.find_longest_common_subsequence('', 'stuff')
    assert_nil DynamicProgrammingLongestCommonSubsequence.find_longest_common_subsequence('stuff', nil)
    assert_nil DynamicProgrammingLongestCommonSubsequence.find_longest_common_subsequence('stuff', '')
    assert_nil DynamicProgrammingLongestCommonSubsequence.find_longest_common_subsequence('', '')
    assert_nil DynamicProgrammingLongestCommonSubsequence.find_longest_common_subsequence(nil, nil)
    assert_nil DynamicProgrammingLongestCommonSubsequence.find_longest_common_subsequence(nil, '')
    assert_nil DynamicProgrammingLongestCommonSubsequence.find_longest_common_subsequence('', nil)
  end

  def test_longest_common_subsequence_length_is_zero_for_words_with_no_overlap
    # skip
    assert_equal '', DynamicProgrammingLongestCommonSubsequence.find_longest_common_subsequence('fish', 'zoo')
  end

  def test_longest_common_subsequence_length_for_similar_sounding_words_with_overlap
    # skip
    assert_equal 'ish', DynamicProgrammingLongestCommonSubsequence.find_longest_common_subsequence('fish', 'hish')
  end

  def test_longest_common_subsequence_length_for_different_sounding_words_with_overlap
    # skip
    assert_equal 'oli', DynamicProgrammingLongestCommonSubsequence.find_longest_common_subsequence('foolish', 'police')
  end

  def test_longest_common_subsequence_length_for_words_with_single_letter_overlap
    # skip
    assert_equal 'u', DynamicProgrammingLongestCommonSubsequence.find_longest_common_subsequence('bump', 'runner')
  end

  def test_longest_common_subsequence_length_for_words_with_two_letter_overlap
    # skip
    assert_equal 'fsh', DynamicProgrammingLongestCommonSubsequence.find_longest_common_subsequence('fish', 'fosh')
  end

  def test_longest_common_subsequence_length_for_words_with_many_sequences
    # skip
    assert_equal 'yccdemmffmptrrzxxz', DynamicProgrammingLongestCommonSubsequence.find_longest_common_subsequence('ybxzccddemmffmptrrrzxxzxp', 'acxyccdremmffmptgrrhzxxtxzwz')
  end

  def test_longest_common_subsequence_length_for_words_with_medium_size_sequences
    # skip
    assert_equal 'emt ole', DynamicProgrammingLongestCommonSubsequence.find_longest_common_subsequence('nematode knowledge', 'empty bottle')
  end


end
