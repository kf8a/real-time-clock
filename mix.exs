defmodule RtcDs3231.MixProject do
  use Mix.Project

  def project do
    [
      app: :rtc_ds3231,
      version: "0.1.0",
      elixir: "~> 1.6-dev",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description:  description(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:elixir_ale, "~> 1.0"},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev},
       {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
    ]
  end

  defp description do
    """
      A library to read a DS3231 Real time clock module

    I've only tested this with a raspberry pi a+ and a sunfounder ds3231 board.

    ## References
    https://datasheets.maximintegrated.com/en/ds/DS3231.pdf
    https://www.sunfounder.com/ds3231-real-time-clock-module.html
    """
  end

  defp package do
    %{
      files: [
        "lib",
        "mix.exs",
        "README.md",
      ],
      maintainers: ["Sven Bohm"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/kf8a/rtc"}
    }
  end
end
