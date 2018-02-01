defmodule ActivityStreams.Type.IntransitiveActivity do
  @moduledoc """
  Instances of IntransitiveActivity are a subtype of Activity representing intransitive actions.
  The object property is therefore inappropriate for these activities.

  [W3C](https://www.w3.org/ns/activitystreams#IntransitiveActivity)
  """
  @required []
  @extends [ActivityStreams.Type.Activity]
  use ActivityStreams.Type.Object, [:actor, :target, :origin, :result, :instrument]

  def valid?(struct) do
    :ok == validate(struct)
  end

  def validate(struct) do
    ActivityStreams.Validator.validate(struct, @required)
  end
end
