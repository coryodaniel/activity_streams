defmodule ActivityStreams.PropValidator.URI do
  @moduledoc """
  """

  @behaviour ActivityStreams.PropValidator

  @doc """
  Validates a URI

  ## Examples

      iex> ActivityStreams.PropValidator.URI.validate("http://example.com")
      :ok

      iex> ActivityStreams.PropValidator.URI.validate("gibberish")
      {:error, "A URI Scheme is required"}

      iex> ActivityStreams.PropValidator.URI.validate("https://")
      {:error, "A host name is required"}
  """
  def validate("" <> v) do
    case URI.parse(v) do
      %URI{scheme: nil} -> {:error, "A URI Scheme is required"}
      %URI{host: nil} -> {:error, "A host name is required"}
      _ -> :ok
    end
  end

  def validate(_), do: {:error, "Invalid type. URI should be a string"}
end
