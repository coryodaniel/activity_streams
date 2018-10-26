defmodule ActivityStreams do
  @moduledoc """
  Documentation for ActivityStreams.
  """

  @mime "application/activity+json"
  @base_url "http://www.w3.org/ns/activitystreams#"
  @contexts [
    "http://www.w3.org/ns/activitystreams",
    "https://www.w3.org/ns/activitystreams",
    "http://www.w3.org/ns/activitystreams#",
    "https://www.w3.org/ns/activitystreams#"
  ]

  # def validate(struct) do
  #   ActivityStreams.Document.build(struct)
  # end

  # def validator(name) do
  #   @defaults
  #   # Application.get_env(:activity_streams, :extensions, %{}
  #   # Application.get_env(:activity_streams, :validators, %{})
  # end

  def decode(json) do
    case Poison.decode(json) do
      {:ok, doc} -> do_decode(doc)
      error -> error
    end
  end

  @default_object %{"type" => "Object"}
  defp do_decode(map) when map == %{}, do: do_decode(@default_object)
  defp do_decode(%{"type" => nil} = doc), do: do_decode(Map.merge(doc, @default_object))

  defp do_decode(%{"type" => type} = doc) do
    case cast_to_module(type) do
      {:ok, mod} ->
        doc = ProperCase.to_snake_case(doc)
        {:ok, build(mod, doc)}

      error ->
        error
    end
  end

  defp do_decode(_), do: {:error, "Top-level must be an object"}

  def decode!(json) do
    {:ok, doc} = decode(json)
    doc
  end

  # Casts a ActiveStreams type name to a module
  defp cast_to_module(type) do
    try do
      {:ok, String.to_existing_atom("Elixir.ActivityStreams.Type.#{type}")}
    rescue
      ArgumentError ->
        {:error, "Unsupported ActivityStream type: '#{type}'"}
    end
  end

  # Creates an ActivityStreams struct from a stringified map
  def build(mod, map) do
    blank = struct(mod)

    keys = Map.keys(blank) -- [:__struct__]

    atomized_map =
      for key <- keys, into: %{} do
        value = Map.get(map, to_string(key))
        {key, value}
      end

    Map.merge(blank, atomized_map)
  end
end
