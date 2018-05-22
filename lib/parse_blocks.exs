defmodule BlockParser do
  @moduledoc """
  Documentation for BlockParser.
  """

  @doc """
  Block parser.

  ## Examples

      iex> MarkdownParser.parse("markdown text")
      "<p>markdown text</p>"

  """
  def parse(string) do
    "<p>" <> string <> "</p>"
  end
end
