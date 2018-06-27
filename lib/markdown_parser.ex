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
    find_token(string)
  end

  @doc """
  Splits markdown text by block

  ## Examples

      iex> MarkdownParser.find_token("markdown test" )
      "<p>markdown test</p>"

  """
  def find_token(:complete_token, token, []) do
    IO.puts("CT1")
    block_identity = identify_block(token)
    parse_block(block_identity)
  end

  def find_token(:complete_token, token, remainder) do
    IO.puts("CT2")
    block_identity = identify_block(token)
    parse_block(block_identity) <> find_token(remainder)
  end

  def find_token(:partial_token, [next_token | remainder]) do
    IO.puts("PT1")
    IO.inspect(next_token)

    if next_token === "" do
      find_token(:complete_token, next_token, remainder)
    else
      find_token(:partial_token, next_token <> hd(remainder), tl(remainder))
    end
  end

  def find_token([next_token | remainder]) do
    IO.puts("PT2")

    if String.match?(next_token, ~r/^[a-zA-Z]/) do
      IO.puts("s")
      IO.inspect(next_token)
      IO.inspect(remainder)
      IO.puts("e")

      if remainder == [] do
        find_token(:complete_token, next_token, remainder)
      else
        if next_token === "" do
          find_token(:complete_token, next_token, remainder)
        else
          appended_token = next_token <> hd(remainder)
          find_token([appended_token | tl(remainder)])
        end
      end
    end
  end

  def find_token(string) do
    IO.puts("SPLITTER")
    String.split(string, "\n") |> find_token
  end

  def identify_block(string) do
    cond do
      string |> String.starts_with?("*") -> {:bullets, string}
      string |> String.starts_with?("#") -> {:header, string}
      true -> {:paragraph, string}
    end
  end

  def parse_block({:paragraph, string}), do: Parser.to_paragraph(string)
  def parse_block({:bullets, string}), do: Parser.to_bullets(string)
  def parse_block({:header, string}), do: Parser.to_header(string)
end
