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

  def find_number(n, n1) do
    if String.upcase(n1) == String.downcase(n1), do: n <> n1, else: n
  end

  def decode(1, l) do
    l
  end

  def decode(n, l) do
    l <> decode(n - 1, l)
  end

  def decode([]) do
    ""
  end

  def decode([n|t]) do
    number = find_number(n, hd(t))
    integer = String.to_integer(number)
    new_list = if number == n <> hd(t), do: List.delete(t, hd(t)), else: t
    letter = hd(new_list)
    list_without_first_letter = List.delete(new_list, letter)
    decode(integer, letter) <> decode(list_without_first_letter)
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    decode(String.codepoints(string))
  end
end
