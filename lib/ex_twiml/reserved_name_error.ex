defmodule ExTwiml.ReservedNameError do
  @moduledoc """
  This error is thrown if you try to use TwiML verb name as a variable name
  in your `twiml` block.

  ## Example

  This code will raise the error, because `number` is a reserved name.

      twiml do
        Enum.each [1, 2], fn(number) ->
          # ...
        end
      end
  """

  defexception [:message]

  @doc false
  @spec exception(list) :: %__MODULE__{}
  def exception([{name, context, _}, file_name]) do
    file_name = Path.relative_to_cwd(file_name)
    name = to_string(name)

    message = ~s"""
    "#{name}" is a reserved name in #{file_name}:#{context[:line]}, because it
    is used to generate the <#{String.capitalize(name)} /> TwiML verb.

    Please use a different variable name.
    """

    %__MODULE__{message: message}
  end
end
