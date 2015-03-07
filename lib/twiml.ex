defmodule Twiml do
  import Twiml.Utilities

  @moduledoc """
  Contains macros to make generating TwiML from Elixir far easier and more 
  efficient. Just `import` the module and go!

  ## Examples

      import Twiml

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

  @nested_verbs [ :gather, :dial ]

  @verbs [
    :say, :number, :play, :sms, :sip, :client, :conference, :queue, :enqueue, 
    :leave, :hangup, :reject, :pause, :record, :redirect
  ]

  @doc """
  Start creating a TwiML document.
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
        unquote(block)
      end

      result = render(var!(buffer, Twiml))   # Convert buffer to string
      :ok = stop_buffer(var!(buffer, Twiml)) # Kill the Agent
      result
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
      put_buffer var!(buffer, Twiml), opening_tag(unquote(name), "", unquote(options))
      unquote(inner)
      put_buffer var!(buffer, Twiml), closing_tag(unquote(name))
    end
  end

  @doc """
  Adds whatever text is given to the current Twiml buffer, unmodified. As a
  result, this macro is really only useful when nested inside one of the other
  macros provided by this module.
  """
  defmacro text(string) do
    quote do
      put_buffer var!(buffer, Twiml), to_string(unquote(string))
    end
  end

  # Generates a macro for each verb that allows nesting of other verbs beneath
  # it. These macros can be used like this:
  #
  #   dial from: "1112223333" do
  #     number "2223334444"
  #     number "3334445555"
  #   end
  #
  # Which will produce this Twiml:
  #
  #   <Dial from="1112223333">
  #     <Number>2223334444</Number>
  #     <Number>3334445555</Number>
  #   </Dial>
  Enum.each @nested_verbs, fn verb ->
    @doc """
    Implements the <#{capitalize verb}> verb. Other verbs can be nested
    under this verb, as shown in the examples.

    See Twilio's official docs for the <#{capitalize verb}> verb here:

    <https://www.twilio.com/docs/api/twiml/#{verb}>

    ## Examples

        twiml do
          #{verb} do
            number "1112223333"
          end
        end
    """
    defmacro unquote(verb)(options, do: inner) do
      current_verb = unquote(verb)

      quote do
        tag unquote(current_verb), unquote(options) do
          unquote(inner)
        end
      end
    end
  end

  # Generates macros for each verb that doesn't support nesting.
  # 
  # Two macros are defined for each verb. The first allows the verb to be called
  # with a string argument, like so:
  # 
  #   verb "Some string", option: "value"
  #
  # Producing the following Twiml:
  #
  #   <Verb option="value">Some string</Verb>
  #
  # The second macro allows the verb to be called in this form:
  #
  #   verb option: "value"
  #
  # This macro will produce a self-closing XML tag, including the attributes.
  #
  #   <Verb option="value" />
  Enum.each @verbs, fn verb ->
    @doc """
    Implements the <#{capitalize verb}> verb. No other verbs can be nested under
    this verb.

    See Twilio's official docs for the <#{capitalize verb}> verb here:

    <https://www.twilio.com/docs/api/twiml/#{verb}>

    ## Examples

        twiml do
          #{verb} "Some text here", option1: "val", option2: "val"
        end

        twiml do
          #{verb} option1: "val", option2: "val"
        end
    """
    defmacro unquote(verb)(first \\ [], options \\ [])
    defmacro unquote(verb)(string, options) when is_binary(string) do
      current_verb = unquote(verb)

      quote do
        tag unquote(current_verb), unquote(options) do
          text unquote(string)
        end
      end
    end
    
    defmacro unquote(verb)(options, _ignore) do
      current_verb = unquote(verb)

      quote do
        put_buffer var!(buffer, Twiml), opening_tag(unquote(current_verb), " /", unquote(options))
      end
    end
  end

  def start_buffer(state), do: Agent.start_link(fn -> state end)
  def stop_buffer(buff), do: Agent.stop(buff)
  def put_buffer(buff, content), do: Agent.update(buff, &[content | &1])
  def render(buff), do: Agent.get(buff, &(&1)) |> Enum.reverse |> Enum.join
end
