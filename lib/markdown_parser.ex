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
    |> Enum.map(fn(x) -> to_paragraph(x); end)
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

  @doc """
  Splits markdown text by block

  ## Examples

      iex> MarkdownParser.to_paragraph("markdown" )
      "<p>markdown</p>"

  """
  def to_paragraph(string) do
    "<p>" <> string <> "</p>"
  end
end
