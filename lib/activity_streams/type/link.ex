defmodule ActivityStreams.Type.Link do
  @moduledoc """
  A Link is an indirect, qualified reference to a resource identified by a URL. The fundamental model for links is established by [ RFC5988]. Many of the properties defined by the Activity Vocabulary allow values that are either instances of Object or Link. When a Link is used, it establishes a qualified relation connecting the subject (the containing object) to the resource identified by the href. Properties of the Link are properties of the reference as opposed to properties of the resource.

  [W3C](https://www.w3.org/ns/activitystreams#Link)
  """

  @required [:href]
  @properties [:height, :href, :hreflang, :id, :media_type, :name, :preview, :type, :rel, :width]
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
