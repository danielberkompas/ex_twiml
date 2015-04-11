defmodule ExTwiml.Utilities do
  @moduledoc """
  A grab bag of helpful functions used to generate XML.

  - `opening_tag/3`: Generate an XML open tag.
  - `closing_tag/1`: Generate an XML close tag.
  - `generate_xml_attributes/1`: Generate a list of XML attributes.
  - `capitalize/1`: Capitalize a string or atom.
  - `to_camel_case/1`: Convert a string or atom to headless camelCase.
  """

  @doc """
  Generates an opening XML tag.

  ## Examples

      iex> import ExTwiml.Utilities
      ...> opening_tag "say", "", option_1: "value"
      "<Say option1=\\"value\\">"
      ...> opening_tag "say", " /", option_1: "value"
      "<Say option1=\\"value\\" />"
  """
  @spec opening_tag(atom, String.t, list) :: String.t
  def opening_tag(tag_name, close, options \\ []) do
    "<#{capitalize(tag_name)}#{xml_attributes(options)}#{close}>"
  end

  @doc """
  Generates a closing XML tag.

  ## Examples

      iex> import ExTwiml.Utilities
      ...> closing_tag("say")
      "</Say>"
  """
  @spec closing_tag(atom) :: String.t
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
  @spec capitalize(atom) :: String.t
  def capitalize(atom) do
    String.capitalize to_string(atom)
  end

  @doc """
  Generate a list of HTML attributes from a keyword list. Keys will be converted
  to headless camelCase.

  See the `to_camel_case/1` function for more details.

  ## Examples

      iex> import ExTwiml.Utilities
      ...> xml_attributes([digits: 1, finish_on_key: "#"])
      " digits=\\"1\\" finishOnKey=\\"#\\""
  """
  @spec xml_attributes(list) :: String.t
  def xml_attributes(attrs) do
    for {key, val} <- attrs, into: "", do: " #{to_camel_case key}=\"#{val}\""
  end

  @doc """
  Convert a string to headless camelCase.

  ## Examples

      iex> import ExTwiml.Utilities
      ...> to_camel_case("finish_on_key")
      "finishOnKey"
  """
  @spec to_camel_case(String.t) :: String.t
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
