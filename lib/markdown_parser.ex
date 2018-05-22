defmodule MarkdownParser do
  @moduledoc """
  Documentation for MarkdownParser.
  """

  @doc """
  Markdown Parser.

  ## Examples

      iex> MarkdownParser.parse("markdown text")
      "<p>markdown text</p>"

  """
  def parse(string) do
    string
    |> split_by_block
    |> Enum.map(fn(x) -> identify_block(x); end)
    |> Enum.map(fn(x) -> parse_block(x); end)
    |> Enum.join("\n")
  end

  @doc """
  Splits markdown text by block

  ## Examples

      iex> MarkdownParser.split_by_block("markdown" <> << 10, 10 >> <> "test" )
      ["markdown", "test"]

  """
  def split_by_block(string) do
    String.split(string, "\n\n")
  end

  def identify_block(string) do
    { :paragraph, string }
  end

  def parse_block(block) do
    case block do
      { :paragraph, string} -> to_paragraph(string)
      { :bullets,   string} -> to_bullets(string)
    end
  end

  @doc """
  Splits markdown text by block

  ## Examples

      iex> MarkdownParser.to_paragraph("markdown" )
      "<p>markdown</p>"

  """
  def to_paragraph(string) do
    "<p>" <> string <> "</p>"
  end

  def to_bullets(string) do
    bullets = String.split(string,"\n")
              |> Enum.map(fn(x) -> String.replace(x,"* ","")  ; end)
              |> Enum.map(fn(x) -> "<li>" <> x <> "</li>" ; end)
              |> Enum.join("\n")
    "<ul>\n" <> bullets <> "\n</ul>"
  end

end
