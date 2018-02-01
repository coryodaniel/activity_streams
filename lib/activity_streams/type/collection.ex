defmodule ActivityStreams.Type.Collection do
  @moduledoc """
  A Collection is a subtype of Object that represents ordered or unordered sets of Object or Link instances. Refer to the Activity Streams 2.0 Core specification for a complete description of the Collection type.

  [W3C](https://www.w3.org/ns/activitystreams#Collection)
  """
  @required []
  @extends [ActivityStreams.Type.Object]
  use ActivityStreams.Type.Object, [:items, :total_items, :first, :last, :current]

  def valid?(struct) do
    :ok == validate(struct)
  end

  def validate(struct) do
    ActivityStreams.Validator.validate(struct, @required)
  end
end
