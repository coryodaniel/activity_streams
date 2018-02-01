defmodule ActivityStreams.Type.CollectionTest do
  use ExUnit.Case, async: true
  alias ActivityStreams.Type.Collection

  describe "W3C Specification Vocabulary Examples (https://www.w3.org/ns/activitystreams#Collection)" do
    test "Example #1" do
      {:ok, collection} =
        "./test/support/examples/vocabulary/type/collection/example_1.json"
        |> File.read!()
        |> ActivityStreams.decode()

      assert Collection.valid?(collection)
    end
  end
end
