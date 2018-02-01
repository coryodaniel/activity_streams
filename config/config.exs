# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :activity_streams, json_library: Poison

# config :activity_streams, :extensions, %{
#   xsd: {IO, :puts}
# }

# {m, f}
# :ok # disables validation, its always OK
config :activity_streams, :validators, %{
  hreflang: :ok,
  name: :ok,
  type: :ok,
  rel: :ok,
  media_type: :ok,
  actor: :ok,
  object: :ok,
  id: :ok,
  summary: :ok,
  items: :ok,
  total_items: :ok,
  first: :ok,
  last: :ok,
  current: :ok,
  part_of: :ok
}
