defmodule ExTwimlTest do
  use ExUnit.Case, async: false

  import ExTwiml

  alias ExTwiml.ReservedNameError

  doctest ExTwiml

  test "can render the <Gather> verb" do
    markup = twiml do
      gather digits: 3 do
        text "Phone Number"
      end
    end

    assert_twiml markup, "<Gather digits=\"3\">Phone Number</Gather>"
  end

  test "can render the <Gather> verb without any options" do
    markup = twiml do
      gather do
        text "Phone Number"
      end
    end

    assert_twiml markup, "<Gather>Phone Number</Gather>"
  end

  test "can render the <Say> verb" do
    markup = twiml do
      say "Hello there!", voice: "woman"
    end

    assert_twiml markup, "<Say voice=\"woman\">Hello there!</Say>"
  end

  test "can render the <Record> verb" do
    markup = twiml do
      record finish_on_key: "#", transcribe: true
    end

    assert_twiml markup, "<Record finishOnKey=\"#\" transcribe=\"true\" />"
  end

  test "can render the <Number> verb" do
    markup = twiml do
      number "1112223333"
    end

    assert_twiml markup, "<Number>1112223333</Number>"
  end

  test "can render the <Play> verb" do
    markup = twiml do
      play "https://api.twilio.com/cowbell.mp3", loop: 10
    end

    assert_twiml markup, "<Play loop=\"10\">https://api.twilio.com/cowbell.mp3</Play>"
  end

  test "can render the <Sms> verb" do
    markup = twiml do
      sms "Hello world!", from: "1112223333", to: "2223334444"
    end

    assert_twiml markup, "<Sms from=\"1112223333\" to=\"2223334444\">Hello world!</Sms>"
  end

  test "can render the <Dial> verb" do
    markup = twiml do
      dial action: "/calls/new" do
        number "1112223333"
      end
    end

    assert_twiml markup, "<Dial action=\"/calls/new\"><Number>1112223333</Number></Dial>"
  end

  test "can render the <Sip> verb" do
    markup = twiml do
      sip "sip:test@example.com", username: "admin", password: "123"
    end

    assert_twiml markup, "<Sip username=\"admin\" password=\"123\">sip:test@example.com</Sip>"
  end

  test "can render the <Client> verb" do
    markup = twiml do
      client "Daniel"
      client "Bob"
    end

    assert_twiml markup, "<Client>Daniel</Client><Client>Bob</Client>"
  end

  test "can render the <Conference> verb" do
    markup = twiml do
      conference "Friendly Conference", end_conference_on_exit: true
    end

    assert_twiml markup, "<Conference endConferenceOnExit=\"true\">Friendly Conference</Conference>"
  end

  test "can render the <Queue> verb" do
    markup = twiml do
      queue "support", url: "about_to_connect.xml"
    end

    assert_twiml markup, "<Queue url=\"about_to_connect.xml\">support</Queue>"
  end

  test "can render the <Enqueue> verb" do
    markup = twiml do
      enqueue "support", wait_url: "wait-music.xml"
    end

    assert_twiml markup, "<Enqueue waitUrl=\"wait-music.xml\">support</Enqueue>"
  end

  test "can render the <Task> verb" do
    markup = twiml do
      task ~s({"selected_language": "it"})
    end

    assert_twiml markup, ~s(<Task>{&quot;selected_language&quot;: &quot;it&quot;}</Task>)
  end

  test "can render the <Task> verb nested inside an <Enqueue> verb" do
    markup = twiml do
      enqueue do
        task ~s({"selected_language": "it"})
      end
    end

    assert_twiml markup, ~s(<Enqueue><Task>{&quot;selected_language&quot;: &quot;it&quot;}</Task></Enqueue>)
  end

  test "can render the <Leave> verb" do
    markup = twiml do
      leave
    end

    assert_twiml markup, "<Leave />"
  end

  test "can render the <Hangup> verb" do
    markup = twiml do
      hangup
    end

    assert_twiml markup, "<Hangup />"
  end

  test "can render the <Redirect> verb" do
    markup = twiml do
      redirect "http://example.com", method: "POST"
    end

    assert_twiml markup, "<Redirect method=\"POST\">http://example.com</Redirect>"
  end

  test "can render the <Reject> verb" do
    markup = twiml do
      reject reason: "busy"
    end

    assert_twiml markup, "<Reject reason=\"busy\" />"

    markup = twiml do
      reject
    end

    assert_twiml markup, "<Reject />"
  end

  test "can render the <Pause> verb" do
    markup = twiml do
      pause length: 5
    end

    assert_twiml markup, "<Pause length=\"5\" />"
  end

  test "can render the <Message> verb" do
    markup = twiml do
      message action: "/hello", method: "post" do
      end
    end

    assert_twiml markup, "<Message action=\"/hello\" method=\"post\"></Message>"
  end

  test "can render the <Body> verb" do
    markup = twiml do
      body "Store location: 203"
    end

    assert_twiml markup, "<Body>Store location: 203</Body>"
  end

  test "can render the <Media> verb" do
    markup = twiml do
      media "https://demo.twilio.com/owl.png"
    end

    assert_twiml markup, "<Media>https://demo.twilio.com/owl.png</Media>"
  end

  test ".twiml can include Enum loops" do
    markup = twiml do
      Enum.each 1..3, fn(n) ->
        say "Press #{n}"
      end
    end

    assert_twiml markup, "<Say>Press 1</Say><Say>Press 2</Say><Say>Press 3</Say>"
  end

  test ".twiml can loop through lists of maps" do
    people = [%{name: "Daniel"}, %{name: "Hunter"}]

    markup = twiml do
      Enum.each people, fn person ->
        say "Hello, #{person.name}!"
      end
    end

    assert_twiml markup, "<Say>Hello, Daniel!</Say><Say>Hello, Hunter!</Say>"
  end

  test ".twiml can 'say' a variable that happens to be a string" do
    some_var = "hello world"
    markup = twiml do
      say some_var
    end

    assert_twiml markup, "<Say>hello world</Say>"
  end

  test ".twiml can 'say' an integer variable" do
    integer = 123
    markup = twiml do
      say integer
    end

    assert_twiml markup, "<Say>123</Say>"
  end

  test ".twiml simple verbs can take options as a variable" do
    options = [voice: "alice"]
    markup = twiml do
      say "I'm Alice", options
    end

    assert_twiml markup, "<Say voice=\"alice\">I&apos;m Alice</Say>"
  end

  test ".twiml self-closing verbs can take options as a variable" do
    options = [length: 31]
    markup = twiml do
      pause options
    end

    assert_twiml markup, "<Pause length=\"31\" />"
  end

  test ".twiml nested verbs can take options as a variable" do
    options = [method: "GET"]
    markup = twiml do
      gather options do
        say "Hi"
      end
    end

    assert_twiml markup, "<Gather method=\"GET\"><Say>Hi</Say></Gather>"
  end

  test ".twiml warns of reserved variable names" do
    ast = quote do
      twiml do
        Enum.each [1, 2], fn(number, text) ->
          say "#{number}"
        end
      end
    end

    assert_raise ReservedNameError, fn ->
      # Simulate compiling the macro
      Macro.expand(ast, __ENV__)
    end
  end
  test "escape message body" do
    markup = twiml do
      message do
        body "hello :<"
      end
    end

    assert_twiml markup, "<Message><Body>hello :&lt;</Body></Message>"
  end

  test "escape simple text" do
    markup = twiml do
        text "hello :<"
    end

    assert_twiml markup, "hello :&lt;"
  end

  test "escape attribute" do
    markup = twiml do
      tag :mms, to: "112345'" do text "hello" end
    end

    assert_twiml markup, "<Mms to=\"112345&apos;\">hello</Mms>"
  end

  defp assert_twiml(lhs, rhs) do
    assert lhs == "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Response>#{rhs}</Response>"
  end
end
