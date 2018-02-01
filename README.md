# ActivityStreams

[ActivityStreams 2.0](https://www.w3.org/ns/activitystreams) validator.

ActivityStreams is a data format for encoding and transferring activity/event metadata.

## This is a WIP

Currently only the [core types](https://www.w3.org/TR/activitystreams-vocabulary/#types) pass validation, which is very _weak_ validation.


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `activity_streams` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:activity_streams, "~> 0.1.2"}
  ]
end
```

Set your JSON decoder of choice

```elixir
config :activity_streams, json_library: Poison # Jason

config :activity_streams, :validators, %{
  rel: {MyRelValidator, :validate}
}
```

A full list of properties is [here](https://www.w3.org/TR/activitystreams-vocabulary/#properties).

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/activity_streams](https://hexdocs.pm/activity_streams).
