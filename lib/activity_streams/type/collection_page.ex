defmodule ActivityStreams.Type.CollectionPage do
  @moduledoc """
  Used to represent distinct subsets of items from a Collection. Refer to the Activity Streams 2.0 Core for a complete description of the CollectionPage object.

  [W3C](https://www.w3.org/ns/activitystreams#CollectionPage)
  """
  @required []
  @extends [ActivityStreams.Type.Collection]
  use ActivityStreams.Type.Object, [
    :items,
    :total_items,
    :first,
    :last,
    :current
  ]

  def valid?(struct) do
    :ok == validate(struct)
  end

  def validate(struct) do
    ActivityStreams.Validator.validate(struct, @required)
  end
end
