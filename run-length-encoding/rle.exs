require IEx
defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """

  def encode([]) do
    ""
  end

  def encode({n, c, []}) do
    "#{n}#{c}"
  end

  def encode({n, h, [h|t]}) do
    encode({1 + n, h, t})
  end


  def encode({n, h1, [h|t]}) do
    encode({n, h1, []}) <> encode({1, h, t})
  end

  def encode([h|t]) do
    encode({1, h, t})
  end

  @spec encode(String.t) :: String.t
  def encode(string) do
    encode(String.codepoints(string))
  end

  def decode("") do
    ""
  end

  def find_number(string) do
    first = String.first(string)
    if String.upcase(first) == String.downcase(first) do
      new_string = String.replace_prefix(string, first, "")
      first <> find_number(new_string)
    else
      ""
    end
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    number = find_number(string)
    integer = String.to_integer(number)
    string_without_number = String.replace_prefix(string, number, "")
    first_letter = String.first(string_without_number)
    new_string = String.replace_prefix(string_without_number, first_letter, "")
    String.duplicate(first_letter, integer) <> decode(new_string)
  end
end
