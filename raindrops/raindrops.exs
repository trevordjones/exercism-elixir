defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    string = (
      Enum.map([3,5,7], &(is_zero?(number, &1)))
      |> Enum.join()
    )
    if string == "", do: to_string(number), else: string
  end

  defp is_zero?(number, factorial) do
    noise = %{3 => "Pling", 5 => "Plang", 7 => "Plong"}
    if (rem(number, factorial) == 0), do: noise[factorial]
  end
end
