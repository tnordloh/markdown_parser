defmodule ParserTest do
  use ExUnit.Case
  doctest Parser

  test "convert text to paragraph" do
    markdown = "hello"
    html     = "<p>hello</p>"
    assert Parser.to_paragraph(markdown) === html
  end

  test "convert text to bullets" do
    markdown = "* one\n* two"
    html = "<ul>\n<li>one</li>\n<li>two</li>\n</ul>"
    assert Parser.to_bullets(markdown) === html
  end

end
