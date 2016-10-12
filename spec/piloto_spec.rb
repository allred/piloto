require 'minitest/autorun'
require_relative '../lib/piloto'

class PilotoTest < Minitest::Test
  def test_one
    refute true == nil
    assert true != nil
  end
end

