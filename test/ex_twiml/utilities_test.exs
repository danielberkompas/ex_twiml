defmodule ExTwiml.UtilitiesTest do
  use ExUnit.Case
  import ExTwiml.Utilities

  test ".opening_tag creates an opening XML tag" do
    assert opening_tag(:address, "/") == "<Address/>"
  end

  test ".closing_tag closes a tag" do
    assert closing_tag(:address) == "</Address>"
  end

  test ".generate_xml_attributes converts a keyword list into XML attributes" do
    options = [finish_on_key: "#", digits: 1]
    assert xml_attributes(options) == " finishOnKey=\"#\" digits=\"1\""
  end

  test ".to_camel_case converts an underscore string into headless camel case" do
    assert to_camel_case(:some_random_string) == "someRandomString"
  end

  test ".to_camel_case does not modify a string already in headless camel case" do
    assert to_camel_case(:someRandomString) == "someRandomString"
  end

  test ".capitalize capitalizes strings and atoms" do
    assert capitalize(:daniel) == "Daniel"
    assert capitalize("daniel") == "Daniel"
  end
end
