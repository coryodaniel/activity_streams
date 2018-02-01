defmodule ActivityStreams.Type.CollectionPageTest do
  use ExUnit.Case, async: true

  describe "W3C Specification Vocabulary Examples (https://www.w3.org/ns/activitystreams#CollectionPage)" do
    test "Example #1" do
      {:ok, page} =
        "./test/support/examples/vocabulary/type/collection_page/example_1.json"
        |> File.read!()
        |> ActivityStreams.decode()

      assert ActivityStreams.Type.CollectionPage.valid?(page)
    end
  end
end
