defmodule ExTwiml.UtilitiesTest do
  use ExUnit.Case

  import ExTwiml.Utilities

  doctest ExTwiml.Utilities

  test ".create_tag reads default options out of application config" do
    Application.put_env(:ex_twiml, :defaults, [say: [voice: "alice"]])
    assert create_tag(:opening, :say) == "<Say voice=\"alice\">"
    Application.delete_env(:ex_twiml, :defaults)
  end

  test ".create_tag allows defaults to be overridden" do
    Application.put_env(:ex_twiml, :defaults, [say: [voice: "alice"]])
    assert create_tag(:opening, :say, voice: "woman") == "<Say voice=\"woman\">"
    Application.delete_env(:ex_twiml, :defaults)
  end

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
