defmodule ActivityStreams.Type.Object do
  @moduledoc """
  Describes an object of any kind. The Object type serves as the base type for most of the other kinds of objects defined in the Activity Vocabulary, including other Core types such as Activity, IntransitiveActivity, Collection and OrderedCollection.

  [W3C](https://www.w3.org/ns/activitystreams#Object)
  """

  @required []
  @properties [
    :attachment,
    :attributed_to,
    :audience,
    :bcc,
    :bto,
    :cc,
    :content,
    :context,
    :duration,
    :end_time,
    :generator,
    :icon,
    :id,
    :image,
    :in_reply_to,
    :location,
    :media_type,
    :name,
    :preview,
    :published,
    :replies,
    :start_time,
    :summary,
    :tag,
    :to,
    :type,
    :updated,
    :url
  ]

  defstruct @properties

  defmacro __using__(properties) do
    properties = @properties ++ properties

    quote do
      defstruct unquote(properties)
    end
  end

  def valid?(struct) do
    :ok == validate(struct)
  end

  def validate(struct) do
    ActivityStreams.Validator.validate(struct, @required)
  end
end
