defmodule ActivityStreams.Type.ActivityTest do
  use ExUnit.Case, async: true
  alias ActivityStreams.Type.Activity

  describe "W3C Specification Vocabulary Examples (https://www.w3.org/ns/activitystreams#Activity)" do
    test "Example #1" do
      {:ok, activity} =
        "./test/support/examples/vocabulary/type/activity/example_1.json"
        |> File.read!()
        |> ActivityStreams.decode()

      assert Activity.valid?(activity)
    end
  end
end
