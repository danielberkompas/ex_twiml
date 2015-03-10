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

## Contributing

Contributions are welcome!

1. Fork the repository
2. Code up your changes
3. Submit a PR back here with your fix.
