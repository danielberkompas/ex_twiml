defmodule ExTwiml.Utilities do
  @doc """
  Generates an opening XML tag.

  ## Examples

      iex> import ExTwiml.Utilities
      ...> opening_tag "say", "", option_1: "value"
      "<Say option1=\\"value\\">"
      ...> opening_tag "say", " /", option_1: "value"
      "<Say option1=\\"value\\" />"
  """
  def opening_tag(tag_name, close, options \\ []) do
    "<#{capitalize(tag_name)}#{generate_xml_attributes(options)}#{close}>"
  end

  @doc """
  Generates a closing XML tag.

  ## Examples

      iex> import ExTwiml.Utilities
      ...> closing_tag("say")
      "</Say>"
  """
  def closing_tag(tag_name) do
    "</#{capitalize(tag_name)}>"
  end

  @doc """
  Capitalize a string or atom.

  ## Examples

      iex> import ExTwiml.Utilities
      ...> capitalize(:atom)
      "Atom"
      ...> capitalize("string")
      "String"
  """
  def capitalize(atom) do
    String.capitalize to_string(atom)
  end

  @doc """
  Generate a list of HTML attributes from a keyword list. Keys will be converted
  to headless camelCase.

  See the `to_camel_case/1` function for more details.

  ## Examples

      iex> import ExTwiml.Utilities
      ...> generate_xml_attributes([digits: 1, finish_on_key: "#"])
      " digits=\\"1\\" finishOnKey=\\"#\\""
  """
  def generate_xml_attributes(keyword_list) do
    Enum.reduce keyword_list, "", fn({key, val}, acc) ->
      acc <> " " <> "#{to_camel_case key}=\"#{val}\""
    end
  end

  @doc """
  Convert a string to headless camelCase.

  ## Examples

      iex> import ExTwiml.Utilities
      ...> to_camel_case("finish_on_key")
      "finishOnKey"
  """
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
