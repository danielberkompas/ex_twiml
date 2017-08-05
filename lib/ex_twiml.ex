defmodule ExTwiml do
  @moduledoc """
  Contains macros to make generating TwiML from Elixir far easier and more
  efficient. Just `import ExTwiml` and go!

  ## Examples

  How to generate nested verbs, such as `<Gather>`:

      # Options are passed before "do"
      gather digits: 1, finish_on_key: "#" do
        # More verbs here ...
      end

      # Generates
      <Gather digits="1" finishOnKey="#"></Gather>

  How to generate simpler verbs, such as `<Say>`:

      # Options are passed as the second argument
      say "words to say", voice: "woman"

      # Generates
      <Say voice="woman">words to say</Say>

  How to generate command verbs, like `<Leave>` or `<Pause>`:

      # If the verb has no attributes, just write the name
      # of the verb:
      leave

      # Generates
      <Leave />

      # If the verb has attributes, like <Pause>, write them
      # after the name of the verb:
      pause length: 5

      # Generates
      <Pause length="5" />

  A complete example:

      import ExTwiml

      twiml do
        play "/assets/welcome.mp3"
        gather digits: 1 do
          say "For more menus, please press 1.", voice: "woman"
          say "To speak with a real person, please press 2.", voice: "woman"
        end
      end

  Produces the following `string`:

      <?xml version="1.0" encoding="UTF-8"?>
      <Response>
        <Play>/assets/welcome.mp3</Play>
        <Gather digits="3">
          <Say voice="woman">For more menus, please press 1.</Say>
          <Say voice="woman">To speak with a real person, please press 2.</Say>
        </Gather>
      </Response>

  You'd then need to render this string to the browser.
  """

  import ExTwiml.Utilities

  alias ExTwiml.ReservedNameError

  @verbs [
    # Nested
    :gather, :dial, :message, :task,

    # Non-nested
    :say, :number, :play, :sms, :sip, :client, :conference, :queue, :enqueue,
    :redirect, :body, :media
  ]

  @simple_verbs [:leave, :hangup, :reject, :pause, :record]

  @doc """
  Start creating a TwiML document. Returns the rendered TwiML as a string.
  See the `ExTwiml` documentation to see how to call TwiML verbs from within
  the `twiml/1` macro.

  ## Example

      iex> import ExTwiml
      ...> twiml do
      ...>   say "Hello World"
      ...> end
      "<?xml version=\\"1.0\\" encoding=\\"UTF-8\\"?><Response><Say>Hello World</Say></Response>"
  """
  defmacro twiml(do: block) do
    quote do
      header = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"

      # Create an Agent to store the buffer results, using var! to allow us to
      # continue to be able to update the buffer through multiple macros.
      #
      # The buffer's state is a list of XML fragments. New fragments are
      # inserted by other macros. Finally, all the fragments are joined
      # together in a string.
      {:ok, var!(buffer, Twiml)} = start_buffer([header])

      # Wrap the whole block in a <Response> tag
      tag :response do
        # Postwalk the AST, expanding all of the TwiML verbs into proper
        # `tag` and `text` macros. This gives the impression that there
        # is a macro for each verb, when in fact it all expands to only
        # two macros.
        unquote(block
                |> Macro.prewalk(&prewalk(&1, __CALLER__.file))
                |> Macro.postwalk(&postwalk/1))
      end

      xml  = render(var!(buffer, Twiml))      # Convert buffer to string
      :ok  = stop_buffer(var!(buffer, Twiml)) # Kill the Agent

      xml # Return our pretty TwiML!
    end
  end

  @doc """
  Use this macro to generate a tag not yet supported by this Twiml library. Note
  that you'll also need to use the `text` macro to include text within this tag.

  ## Examples

      tag :mms, to: "1112223333", from: "2223334444" do
        text "How are you doing?"
      end

  Will produce the following Twiml:

      <Mms to="1112223333" from="2223334444">How are you doing?</Mms>
  """
  defmacro tag(name, options \\ [], do: inner) do
    quote do
      put_buffer var!(buffer, Twiml), create_tag(:opening, unquote(name), unquote(options))
      unquote(inner)
      put_buffer var!(buffer, Twiml), create_tag(:closing, unquote(name))
    end
  end

  @doc """
  Adds whatever text is given to the current Twiml buffer, unmodified. As a
  result, this macro is really only useful when nested inside one of the other
  macros provided by this module.
  """
  defmacro text(string) do
    quote do
      put_buffer var!(buffer, Twiml), escape_text(to_string(unquote(string)))
    end
  end

  @doc "Start an Agent to store a given buffer state."
  @spec start_buffer(list) :: {:ok, pid}
  def start_buffer(state), do: Agent.start_link(fn -> state end)

  @doc "Stop a buffer."
  @spec stop_buffer(pid) :: atom
  def stop_buffer(buff), do: Agent.stop(buff)

  @doc "Update the buffer by pushing a new tag onto the beginning."
  @spec put_buffer(pid, any) :: atom
  def put_buffer(buff, content), do: Agent.update(buff, &[content | &1])

  @doc "Get the current state of a buffer."
  @spec get_buffer(pid) :: list
  def get_buffer(buff), do: Agent.get(buff, &(&1)) |> Enum.reverse

  @doc "Render the contents of the buffer into a string."
  @spec render(pid) :: String.t
  def render(buff), do: Agent.get(buff, &(&1)) |> Enum.reverse |> Enum.join

  ##
  # Private API
  ##

  # Check function definitions for reserved variable names
  defp prewalk({:fn, _, [{:->, _, [vars, _]}]} = ast, file_name) do
    assert_no_verbs!(vars, file_name)
    ast
  end

  defp prewalk(ast, _file_name), do: ast

  # {:text, [], ["Hello World"]}
  defp postwalk({:text, _meta, [string]}) do
    # Just add the text to the buffer. Nothing else needed.
    quote do: text unquote(string)
  end

  # {:gather, [], [[do: inner]]}
  defp postwalk({verb, _meta, [[do: inner]]}) when verb in @verbs do
    compile_nested(verb, [], inner)
  end

  # {:gather, [], [finish_on_key: "#", [do: inner]]}
  defp postwalk({verb, _meta, [options, [do: inner]]}) when verb in @verbs do
    compile_nested(verb, options, inner)
  end

  # {:say, [], ["Hello World", [voice: "woman"]}
  defp postwalk({verb, _meta, [string, options]}) when verb in @verbs do
    compile_simple(verb, string, options)
  end

  # {:say, [], ["Hello World"]}
  # {:say, [], ["Hello #{var}"]} (String interpolation)
  defp postwalk({verb, _meta, [string]}) when verb in @verbs do
    compile_simple(verb, string)
  end

  # {:pause, [], [[length: 5]]}
  defp postwalk({verb, _meta, [options]}) when verb in @simple_verbs do
    compile_empty(verb, options)
  end

  # {:leave, [], Elixir}
  defp postwalk({verb, _meta, _args}) when verb in @simple_verbs do
    compile_empty(verb)
  end

  # Don't modify any other ASTs.
  defp postwalk(ast), do: ast

  # For nested verbs, such as <Gather>
  defp compile_nested(verb, options, inner) do
    quote do
      tag unquote(verb), unquote(options) do
        unquote(inner)
      end
    end
  end

  # For simple verbs, such as <Say>
  defp compile_simple(verb, string, options \\ []) do
    quote do
      tag unquote(verb), unquote(options) do
        text unquote(string)
      end
    end
  end

  # For verbs without content, like <Leave> or <Pause>
  defp compile_empty(verb, options \\ []) do
    quote do
      # Render only a single tag, with options
      put_buffer var!(buffer, Twiml), create_tag(:self_closed, unquote(verb), unquote(options))
    end
  end

  defp assert_no_verbs!(vars, file_name) when is_list(vars) do
    Enum.each(vars, &assert_no_verbs!(&1, file_name))
  end

  defp assert_no_verbs!({name, _, _} = var, file_name)
  when is_atom(name) and name in @verbs do
    raise ReservedNameError, [var, file_name]
  end

  defp assert_no_verbs!(vars, _file_name) do
    vars
  end
end
