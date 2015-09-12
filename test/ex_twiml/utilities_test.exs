defmodule ExTwiml.UtilitiesTest do
  use ExUnit.Case
  import ExTwiml.Utilities

  doctest ExTwiml.Utilities

  test ".generate_xml_attributes converts a keyword list into XML attributes" do
    options = [finish_on_key: "#", digits: 1]
    assert xml_attributes(options) == " finishOnKey=\"#\" digits=\"1\""
  end

  test ".camelize converts an underscore string into headless camel case" do
    assert camelize(:some_random_string) == "someRandomString"
  end

  test ".camelize does not modify a string already in headless camel case" do
    assert camelize(:someRandomString) == "someRandomString"
  end

  test ".capitalize capitalizes strings and atoms" do
    assert capitalize(:daniel) == "Daniel"
    assert capitalize("daniel") == "Daniel"
  end
end
