defmodule ExTwiml.ReservedNameErrorTest do
  use ExUnit.Case

  alias ExTwiml.ReservedNameError

  test ".exception returns a nice exception" do
    %{message: message} = ReservedNameError.exception([{:number, [line: 1], []},
                                                      "test/test.ex"])

    assert message == ~s"""
    "number" is a reserved name in test/test.ex:1, because it
    is used to generate the <Number /> TwiML verb.

    Please use a different variable name.
    """
  end
end
