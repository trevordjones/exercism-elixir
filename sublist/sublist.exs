defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def is_sublist?(_, []) do
    false
  end

  def is_sublist?(a, b) do
    if a == (Enum.chunk(b, length(a)) |> List.first), do: true, else: is_sublist?(a, tl(b))
  end

  def is_superlist?([], _) do
    false
  end

  def is_superlist?(a, b) do
    if b == (Enum.chunk(a, length(b)) |> List.first), do: true, else: is_superlist?(tl(a), b)
  end

  def compare(a, b) do
    cond do
      a == b ->
        :equal
      a == [] ->
        :sublist
      b == [] ->
        :superlist
      is_sublist?(a, b) ->
        :sublist
      is_superlist?(a, b) ->
        :superlist
      a != b ->
        :unequal
      true ->
        :sublist
    end
  end
end
