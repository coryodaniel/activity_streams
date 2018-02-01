defmodule ActivityStreamsTest do
  use ExUnit.Case, async: true

  # test "invalid @context"
  # "Top-level does not contain a '@context' property"
  # "'@context' property does not refer to Activity Streams context"
  # "'@context' property is neither a string nor an object"
  # "'@context'" if its a map -> see spec

  describe "decode/1" do
    test "decodes a valid ActivityStreams type" do
      json = ~s"""
      {
        "@context": "https://www.w3.org/ns/activitystreams",
        "id": "my-id",
        "type": "Object"
      }
      """

      assert {:ok, doc} = ActivityStreams.decode(json)
      assert doc.__struct__ == ActivityStreams.Type.Object
    end

    test "returns an Object when no type provided" do
      # All properties are optional (including the id and type)

      assert {:ok, doc} = ActivityStreams.decode("{}")
      assert doc.__struct__ == ActivityStreams.Type.Object
    end

    test "returns an error when not given an object" do
      assert {:error, "Top-level must be an object"} = ActivityStreams.decode("[]")
    end

    test "returns an error on unrecognized type" do
      json = ~s"""
      {
        "@context": "https://www.w3.org/ns/activitystreams",
        "type": "Hamburger"
      }
      """

      assert {:error, msg} = ActivityStreams.decode(json)
      assert msg == "Unsupported ActivityStream type: 'Hamburger'"
    end
  end
end
