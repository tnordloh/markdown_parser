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
    cond do
      string |> String.starts_with?("*") -> {:bullets, string}
      string |> String.starts_with?("#") -> {:header, string}
      true -> {:paragraph, string}
    end
  end

  def parse_block({:paragraph, string}), do: Parser.to_paragraph(string)
  def parse_block({:bullets,   string}), do: Parser.to_bullets(string)
  def parse_block({:header,    string}), do: Parser.to_header(string)

end
