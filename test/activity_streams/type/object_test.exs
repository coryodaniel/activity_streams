defmodule ActivityStreams.Type.ObjectTest do
  use ExUnit.Case, async: true
  alias ActivityStreams.Type.Object

  describe "W3C Specification Vocabulary Examples (https://www.w3.org/ns/activitystreams#Object)" do
    test "Example #1" do
      {:ok, object} =
        "./test/support/examples/vocabulary/type/object/example_1.json"
        |> File.read!()
        |> ActivityStreams.decode()

      assert object.__struct__ == Object
      IO.inspect(Object.validate(object))
      assert Object.valid?(object)
    end
  end

  describe "valid?/1" do
    test "All properties are optional (including the id and type)" do
      assert Object.valid?(%Object{})
    end
  end
end

# TODO:
# describe "Object.valid?/1" do
#   # For instance, some vocabularies (e.g. The Good Relations Vocabulary)
#   # define their own types for describing locations.
#   # An implementation that wishes, for example, to
#   # use a http://purl.org/goodrelations/v1#Location as an
#   # object type *must* also identify the object as being a
#   # "Place"
#   test "When an implementation uses an extension type that overlaps with a core vocabulary type, the implementation must also specify the core vocabulary type"
#   test "When external vocabularies overlap or duplicate AS vocabulary implementations *must* favor the use of properties defined by the Activity Vocabulary"
#
#
# end
#
# describe "Text representations of object types" do
#   test "The name property *should* be derived from input by the creator or another user."
#   test "The summary property *should* be used as a fallback text representation, possibly automatically generated by the publisher."
# end
