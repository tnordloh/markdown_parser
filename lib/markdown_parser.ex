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
    "<p>" <> string <> "</p>"
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

end
