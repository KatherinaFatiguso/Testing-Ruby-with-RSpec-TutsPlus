# this doesn't work, old version.
class StringExtensionTest < ActionController::Test
  def test_is_number
    assert "3".is_number?
  end

  def test_is_not_number
    assert !"Blah".is_number?
  end
end
