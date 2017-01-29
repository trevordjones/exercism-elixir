defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence
    |> String.downcase
    |> remove_punctuation
    |> String.split()
    |> count_words
    |> Enum.into(%{})
  end

  defp count(word, words) do
    Enum.count(words, &(&1 == word))
  end

  defp remove_punctuation(sentence) do
    String.replace(sentence, ~r/[!@,:%&\$\^_]/ , " ")
  end

  defp count_words(words) do
    Enum.map(words, &{&1, (count(&1, words))})
    # OR (and remove line 14 above)
    # Enum.reduce(words, %{}, fn(word, map) ->
    #   Map.update(map, word, 1, &(&1 + 1))
    # end)
  end
end
