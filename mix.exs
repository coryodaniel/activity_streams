defmodule ActivityStreams.MixProject do
  use Mix.Project
  @version "0.1.2"

  def project do
    [
      app: :activity_streams,
      version: @version,
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package(),
      description: "ActivityStreams is a data format for encoding and transferring activity/event metadata"
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
      {:poison, ">= 0.0.0"},
      {:proper_case, "~> 1.0.2"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:mix_test_watch, "~> 0.5", only: :dev, runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Cory O'Daniel"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/coryodaniel/activity_streams",
        "ActivitStreams W3C" => "https://www.w3.org/ns/activitystreams",
        "ActivityStreams-Core W3C" => "https://www.w3.org/TR/activitystreams-core/",
        "ActivityStreams-Vocabulary W3C" => "https://www.w3.org/TR/activitystreams-vocabulary/"
      },
      files: ~w(mix.exs lib) ++ ~w(README.md CHANGELOG.md .formatter.exs)
    ]
  end

  defp docs do
    [
      main: "readme",
      source_ref: "v#{@version}",
      canonical: "http://hexdocs.pm/activity_streams",
      source_url: "https://github.com/coryodaniel/activity_streams",
      extras: [
        "README.md",
        "CHANGELOG.md"
      ]
    ]
  end
end
