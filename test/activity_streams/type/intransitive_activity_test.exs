defmodule ActivityStreams.Type.IntransitiveActivityTest do
  use ExUnit.Case, async: true
  alias ActivityStreams.Type.IntransitiveActivity

  describe "W3C Specification Vocabulary Examples (https://www.w3.org/ns/activitystreams#IntransitiveActivity)" do
    test "Example #1" do
      {:ok, activity} =
        "./test/support/examples/vocabulary/type/intransitive_activity/example_1.json"
        |> File.read!()
        |> ActivityStreams.decode()

      assert IntransitiveActivity.valid?(activity)
    end
  end
end
