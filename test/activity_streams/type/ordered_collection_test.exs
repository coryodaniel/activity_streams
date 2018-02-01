defmodule ActivityStreams.Type.OrderedCollectionTest do
  use ExUnit.Case, async: true

  describe "W3C Specification Vocabulary Examples (https://www.w3.org/ns/activitystreams#OrderedCollection)" do
    test "Example #1" do
      {:ok, collection} =
        "./test/support/examples/vocabulary/type/ordered_collection/example_1.json"
        |> File.read!()
        |> ActivityStreams.decode()

      assert ActivityStreams.Type.OrderedCollection.valid?(collection)
    end
  end
end
