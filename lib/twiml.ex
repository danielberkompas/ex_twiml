defmodule Twiml do
  @nested_verbs [:gather, :dial]
  @verbs [
    :say, 
    :number, 
    :play, 
    :sms, 
    :sip, 
    :client, 
    :conference, 
    :queue, 
    :enqueue, 
    :leave,
    :hangup,
    :reject,
    :pause,
    :record,
    :redirect
  ]

  defmacro twiml(do: block) do
    quote do
      header = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"

      {:ok, var!(buffer, Twiml)} = start_buffer([header])

      tag :response do
        unquote(block)
      end

      result = render(var!(buffer, Twiml))
      :ok = stop_buffer(var!(buffer, Twiml))
      result
    end
  end

  Enum.each @nested_verbs, fn verb ->
    defmacro unquote(verb)(options, do: inner) do
      current_verb = unquote(verb)

      quote do
        tag unquote(current_verb), unquote(options) do
          unquote(inner)
        end
      end
    end
  end

  Enum.each @verbs, fn verb ->
    defmacro unquote(verb)(first \\ [], options \\ [])
    defmacro unquote(verb)(string, options) when is_binary(string) do
      current_verb = unquote(verb)

      quote do
        tag unquote(current_verb), unquote(options) do
          text unquote(string)
        end
      end
    end
    
    # Self closing version
    defmacro unquote(verb)(options, _ignore) do
      current_verb = unquote(verb)

      quote do
        put_buffer var!(buffer, Twiml), open_tag(unquote(current_verb), " /", unquote(options))
      end
    end
  end

  defmacro tag(name, options \\ [], do: inner) do
    quote do
      put_buffer var!(buffer, Twiml), open_tag(unquote(name), "", unquote(options))
      unquote(inner)
      put_buffer var!(buffer, Twiml), close_tag(unquote(name))
    end
  end

  defmacro text(string) do
    quote do
      put_buffer var!(buffer, Twiml), to_string(unquote(string))
    end
  end

  def start_buffer(state), do: Agent.start_link(fn -> state end)
  def stop_buffer(buff), do: Agent.stop(buff)
  def put_buffer(buff, content), do: Agent.update(buff, &[content | &1])
  def render(buff), do: Agent.get(buff, &(&1)) |> Enum.reverse |> Enum.join

  def open_tag(tag_name, close, options \\ []) do
    "<#{capitalize tag_name}#{generate_options options}#{close}>"
  end

  def close_tag(tag_name) do
    "</#{capitalize tag_name}>"
  end

  def generate_options(options) do
    Enum.reduce options, "", fn({key, val}, acc) ->
      acc <> " " <> "#{camel_case to_string(key)}=\"#{val}\""
    end
  end

  def camel_case(string) do
    String.split(string, "_") 
    |> Enum.with_index
    |> Enum.map(fn {str, i} ->
      case i do
        0 -> str
        _ -> String.capitalize(str)
      end
    end)
    |> Enum.join
  end

  def capitalize(atom) do
    String.capitalize to_string(atom)
  end
end
