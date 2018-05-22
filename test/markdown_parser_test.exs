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

  test "convert text to paragraph" do
    markdown = "hello"
    html     = "<p>hello</p>"
    assert MarkdownParser.to_paragraph(markdown) === html
  end
end
