defmodule ActivityStreams.Type.OrderedCollectionPage do
  @moduledoc """
  Used to represent ordered subsets of items from an OrderedCollection. Refer to the Activity Streams 2.0 Core for a complete description of the OrderedCollectionPage object.

  [W3C](https://www.w3.org/ns/activitystreams#OrderedCollectionPage)
  """

  @required []
  @extends [ActivityStreams.Type.OrderedCollection, ActivityStreams.Type.CollectionPage]
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
