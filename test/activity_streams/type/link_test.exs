defmodule ActivityStreams.Type.LinkTest do
  use ExUnit.Case, async: true
  alias ActivityStreams.Type.Link

  describe "W3C Specification Vocabulary Examples (https://www.w3.org/ns/activitystreams#Link)" do
    test "Example #1" do
      {:ok, link} =
        "./test/support/examples/vocabulary/type/link/example_1.json"
        |> File.read!()
        |> ActivityStreams.decode()

      assert link.__struct__ == Link
      assert Link.valid?(link)
    end
  end

  describe "valid?/1" do
    test "a valid link" do
      assert Link.valid?(%Link{href: "http://example.com"})
    end

    test "a invalid link" do
      refute Link.valid?(%Link{rel: "popup"})
    end
  end

  describe "validate/1" do
    test "requires the href field" do
      {:error, bad_link} = Link.validate(%Link{rel: "thumbnail"})
      assert bad_link.errors[:href] == "is required"

      assert :ok = Link.validate(%Link{href: "http://example.com"})
    end

    test "requires a valid URI" do
      {:error, bad_link} = Link.validate(%Link{href: "gibberish"})
      assert bad_link.errors[:href] == "A URI Scheme is required"
    end
  end
end

# TODO:
# * Link
#   * [ ] It ought to be noted that the [HTML5] specification provides its own alternative definition of a "link relation" that differs slightly from the [RFC5988] definition. In the HTML5 definition, any string that does not contain the "space" U+0020, "tab" (U+0009), "LF" (U+000A), "FF" (U+000C), "CR" (U+000D) or "," (U+002C) characters can be used as a valid link relation. To promote interoperability, Activity Streams 2.0 implementations *must* only use link relations that are syntactically valid in terms of both the [RFC5988] and [HTML5] definitions.
#   * [ ] When an implementation uses an extension type that overlaps with a core vocabulary type, the implementation *must* also specify the core vocabulary type. For instance, some vocabularies (e.g. Schema.org) define their own types for describing actions. An implementation that wishes, for example, to use http://schema.org/LikeAction as an Activity *must* also identify that Object as being a Like as illustrated in the following
# * hreflang
#   * [ ] Hints as to the language used by the target resource. Value *must* be a [BCP47] Language-Tag.
# * rel
#   * [ ] A link relation associated with a Link. The value *must* conform to both the [HTML5] and [RFC5988] "link relation" definitions.
# * Representing places
#   * [ ] While publishers are not *required* to use these specific properties and *may* make use of other mechanisms for describing locations, consuming implementations that support the Place object *must* support the use of these properties.
