ExTwiml 
===================
[![Build Status](https://travis-ci.org/danielberkompas/ex_twiml.svg)](https://travis-ci.org/danielberkompas/ex_twiml)

Generate TwiML for your [Twilio](http://twilio.com) integration, right inside
Elixir! This is the first step toward a comprehensive Twilio integration library
I'm writing for Elixir, but it can be used entirely on its own.

## Installation

ExTwiml can be installed through mix. First, update your dependencies in
`mix.exs`.

```elixir
defp deps
  [{:ex_twiml, github: "danielberkompas/ex_twiml"}]
end
```

Then run `mix deps.get`, and ExTwiml will be installed.

## Usage

Import the `ExTwiml` module into your module, and then use the `twiml` macro to 
generate your TwiML, like so:

```elixir
defmodule YourModule do
  import ExTwiml

  def render do
    twiml do
      play "/assets/welcome.mp3"
      gather digits: 4, finish_on_key: "#" do
        say """
        Please enter the last four digits of your credit card number, followed 
        by the pound sign.
        """, voice: "woman"
      end
    end
  end
end
```

You can then render the TwiML by calling `YourModule.render/0`. The output will 
be a binary in this format:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Response>
  <Play>/assets/welcome.mp3</Play>
  <Gather digits="4" finishOnKey="#">
    <Say voice="woman">
      Please enter the last four digits of your credit card number, followed by
      the pound sign.
    </Say>
  </Gather>
</Response>
```

The `twiml` macro simply returns a binary (or string), so you're not limited to
the pattern above. Just use `twiml` wherever you need a TwiML string.

## Supported Verbs and Nouns
See the [Twilio Documentation](https://www.twilio.com/docs/api/twiml) for a
complete list of verbs supported by Twilio. ExTwiml has built in macros for the
following verbs and nouns:

- [<Say>](https://www.twilio.com/docs/api/2010-04-01/twiml/say)
- [<Play>](https://www.twilio.com/docs/api/2010-04-01/twiml/play)
- [<Gather>](https://www.twilio.com/docs/api/2010-04-01/twiml/gather)
- [<Record>](https://www.twilio.com/docs/api/2010-04-01/twiml/record)
- [<Sms>](https://www.twilio.com/docs/api/2010-04-01/twiml/sms)
- [<Dial>](https://www.twilio.com/docs/api/2010-04-01/twiml/dial)
    - [<Number>](https://www.twilio.com/docs/api/2010-04-01/twiml/number)
    - [<Sip>](https://www.twilio.com/docs/api/2010-04-01/twiml/sip)
    - [<Client>](https://www.twilio.com/docs/api/2010-04-01/twiml/client)
    - [<Conference>](https://www.twilio.com/docs/api/2010-04-01/twiml/conference)
    - [<Queue>](https://www.twilio.com/docs/api/2010-04-01/twiml/queue)
- [<Enqueue>](https://www.twilio.com/docs/api/2010-04-01/twiml/enqueue)
- [<Leave>](https://www.twilio.com/docs/api/2010-04-01/twiml/leave)
- [<Hangup>](https://www.twilio.com/docs/api/2010-04-01/twiml/hangup)
- [<Redirect>](https://www.twilio.com/docs/api/2010-04-01/twiml/redirect)
- [<Reject>](https://www.twilio.com/docs/api/2010-04-01/twiml/reject)
- [<Pause>](https://www.twilio.com/docs/api/2010-04-01/twiml/pause)
- [<Message>](https://www.twilio.com/docs/api/2010-04-01/twiml/message)
    - [<Body>](https://www.twilio.com/docs/api/2010-04-01/twiml/body)
    - [<Media>](https://www.twilio.com/docs/api/2010-04-01/twiml/media)
- [<Redirect>](https://www.twilio.com/docs/api/2010-04-01/twiml/redirect)

Supported verbs can be called in three forms:

```elixir
# Verbs that support nesting, like <Gather> and <Dial>:
verb option_1: "value", option_2: "value" do
    # Nested verbs here
end
# => "<Verb option1="value" option2="value">Nested verbs here</Verb>":

# Verbs that don't support nesting, like <Say>
twiml do
  verb "Inner text", option_1: "value", option_2: "value"
end
# => "<Verb option1="value" option2="value">Inner text</Verb>"

# Verbs that have no inner content, like <Reject>:
reject reason: "busy"
# => "<Reject reason="busy" />"
```

To maximize compatibility with future versions of the TwiML spec, ExTwiml
**does not** validate the attributes passed to the various verbs to ensure that
they are supported by Twilio. You'll need to do this yourself.

### Unsupported Verbs?
If the Twilio API adds a verb and I haven't yet created a macro for it, you can do
two things:

1. Submit a PR to add it
2. Use the `tag` macro in the meantime while the PR is reviewed

The tag macro can be used to create arbitrary XML tags in the output, like this:

```elixir
tag :custom, option_1: "value" do
  tag :speak, do: "Whatever you say, boss!"
end
# => "<Custom option1="value"><Speak>Whatever you say, boss!</Speak></Custom>"
```

## Contributing

Contributions are welcome!

1. Fork the repository
2. Code up your changes
3. Submit a PR back here with your fix.
