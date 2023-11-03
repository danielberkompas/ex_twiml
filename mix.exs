defmodule ExTwiml.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_twiml,
     description: "Generate TwiML with Elixir",
     version: "2.1.3",
     elixir: "~> 1.0",
     deps: deps(),
     dialyzer: [
       plt_file: "#{System.get_env("HOME")}/#{plt_filename()}",
       flags: ["--no_native", "-Wno_match", "-Wno_return"]
     ],
     package: package()]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: [:dev, :docs]},
      {:inch_ex, ">= 0.0.0", only: :docs}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "CHANGELOG.md", "LICENSE"],
      maintainers: ["Daniel Berkompas"],
      licenses: ["MIT"],
      links: %{
        "Github" => "https://github.com/danielberkompas/ex_twiml"
      }
    ]
  end

  defp plt_filename do
    "elixir-#{System.version()}_#{otp_release()}.plt"
  end

  defp otp_release do
    case System.get_env("TRAVIS_OTP_RELEASE") do
      nil     -> :erlang.system_info(:otp_release)
      release -> release
    end
  end
end
