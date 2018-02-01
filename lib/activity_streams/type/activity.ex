defmodule ActivityStreams.Type.Activity do
  @moduledoc """
  An Activity is a subtype of Object that describes some form of action that may happen, is currently happening, or has already happened. The Activity type itself serves as an abstract base type for all types of activities. It is important to note that the Activity type itself does not carry any specific semantics about the kind of action being taken.

  [W3C](https://www.w3.org/ns/activitystreams#Activity)
  """
  @required []
  @extends [ActivityStreams.Type.Object]
  use ActivityStreams.Type.Object, [:actor, :object, :target, :origin, :result, :instrument]

  def valid?(struct) do
    :ok == validate(struct)
  end

  def validate(struct) do
    ActivityStreams.Validator.validate(struct, @required)
  end
end
