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

  test "convert text header bullets" do
    markdown = "###### aich6"
    html = "<H6>aich6</H6>"
    assert Parser.to_header(markdown) === html

    markdown = "#### aich4"
    html = "<H4>aich4</H4>"
    assert Parser.to_header(markdown) === html

    markdown = "#### aich4 #########"
    html = "<H4>aich4</H4>"
    assert Parser.to_header(markdown) === html

    markdown = "#### ai # ch4 #########"
    html = "<H4>ai # ch4</H4>"
    assert Parser.to_header(markdown) === html

  end
end
