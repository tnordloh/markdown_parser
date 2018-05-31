defmodule Parser do

  @doc """
  converts markdown to paragraph

  ## Examples

      iex> Parser.to_paragraph("markdown" )
      "<p>markdown</p>"

  """
  def to_paragraph(string) do
    "<p>" <> string <> "</p>"
  end

  @doc """
  Splits markdown text by block

  ## Examples

      iex> String.replace(Parser.to_bullets("* one"), << 10 >> ,"x")
      "<ul>x<li>one</li>x</ul>"

  """
  def to_bullets(string) do
    bullets = String.split(string,"\n")
              |> Enum.map(fn(x) -> String.replace(x,"* ","")  ; end)
              |> Enum.map(fn(x) -> "<li>" <> x <> "</li>" ; end)
              |> Enum.join("\n")
    "<ul>\n" <> bullets <> "\n</ul>"
  end

  def to_header(string) do
    header_elements = Regex.named_captures(~r/(?<count>\#+)(\s+)(?<text>((?![# ]+$).)*)(\s\#+)*/, string)
    size = String.length(header_elements["count"])
    |> Integer.to_string
    "<H" <> size <> ">" <> header_elements["text"] <> "</H" <> size <> ">"
  end
end
