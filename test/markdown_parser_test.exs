defmodule MarkdownParserTest do
  use ExUnit.Case
  doctest MarkdownParser

  test "converts a markdown paragraph to html" do
    markdown= """
    This is a multiline string,
    it represents a paragraph.
    it should be returned with paragraph tags around it.
    """
    html= """
    <p>This is a multiline string,
    it represents a paragraph.
    it should be returned with paragraph tags around it.
    </p>
    """
    assert MarkdownParser.parse(markdown) == String.trim_trailing(html,"\n")
  end

  test "converts two markdown paragraphs to html" do
    markdown= """
    This is a multiline string, for two paragraphs.

    this is the second paragraph
    """ |> String.trim_trailing("\n")
    html= """
    <p>This is a multiline string, for two paragraphs.</p>
    <p>this is the second paragraph</p>
    """
    assert MarkdownParser.parse(markdown) == String.trim_trailing(html,"\n")
  end

  test "split multi-block markdown document" do
    markdown= "This is a multiline string,\n\nit should be returned as a list."
    html= ["This is a multiline string,", "it should be returned as a list." ]
    html = Enum.map(html, fn(x) -> String.trim_trailing(x) ; end)
    assert MarkdownParser.split_by_block(markdown) == html
  end

  test "correctly reads different types of markdown" do
    bullets =          "* one\n* two"
    bullets_html       = "<ul>\n<li>one</li>\n<li>two</li>\n</ul>"
    paragraph          = "hello"
    paragraph_html     = "<p>hello</p>"
    total_md = bullets <> "\n\n" <> paragraph
    total_html       = bullets_html <> "\n" <> paragraph_html
    assert MarkdownParser.parse(total_md) === total_html
  end
end
