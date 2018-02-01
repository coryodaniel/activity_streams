defmodule ActivityStreams.Type.OrderedCollectionPageTest do
  use ExUnit.Case, async: true
  alias ActivityStreams.Type.OrderedCollectionPage

  describe "W3C Specification Vocabulary Examples (https://www.w3.org/ns/activitystreams#OrderedCollectionPage)" do
    test "Example #1" do
      {:ok, page} =
        "./test/support/examples/vocabulary/type/ordered_collection_page/example_1.json"
        |> File.read!()
        |> ActivityStreams.decode()

      IO.inspect(OrderedCollectionPage.validate(page))
      assert OrderedCollectionPage.valid?(page)
    end
  end
end
