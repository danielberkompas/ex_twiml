defmodule Twiml.Utilities do
  def opening_tag(tag_name, close, options \\ []) do
    "<#{capitalize(tag_name)}#{generate_xml_attributes(options)}#{close}>"
  end

  def closing_tag(tag_name) do
    "</#{capitalize(tag_name)}>"
  end

  def capitalize(atom) do
    String.capitalize to_string(atom)
  end

  def generate_xml_attributes(keyword_list) do
    Enum.reduce keyword_list, "", fn({key, val}, acc) ->
      acc <> " " <> "#{to_camel_case key}=\"#{val}\""
    end
  end

  def to_camel_case(string) do
    to_string(string)
    |> String.split("_")
    |> Enum.with_index
    |> Enum.map(fn {str, i} ->
      case i do
        0 -> str
        _ -> String.capitalize(str)
      end
    end)
    |> Enum.join
  end
end
