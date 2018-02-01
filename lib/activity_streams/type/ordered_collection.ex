defmodule ActivityStreams.Type.OrderedCollection do
  @moduledoc """
  A subtype of Collection in which members of the logical collection are assumed to always be strictly ordered.

  [W3C](https://www.w3.org/ns/activitystreams#OrderedCollection)
  """

  @required []
  @extends [ActivityStreams.Type.Collection]
  use ActivityStreams.Type.Object, [
    :items,
    :total_items,
    :first,
    :last,
    :current,
    :part_of,
    :next,
    :prev
  ]

  def valid?(struct) do
    :ok == validate(struct)
  end

  def validate(struct) do
    ActivityStreams.Validator.validate(struct, @required)
  end
end
