defmodule ActivityStreams.PropValidator do
  @moduledoc false

  @callback validate(term()) :: :ok | {:error, String.t()}
  @defaults %{
    href: {ActivityStreams.PropValidator.URI, :validate}
  }

  # TODO:
  # * [ ] Merge validators sources
  #   * Defaults -> config.namespace -> conf.validators -> opts
  # * [ ] Handle functional properties
  def validate(prop, value) do
    case validator_for(prop) do
      nil -> {:error, "ActivityStreams.PropValidator not registered"}
      validator -> dispatch(validator, value)
    end
  end

  def dispatch(:ok, _), do: :ok
  def dispatch(fun, value) when is_function(fun, 1), do: fun.(value)

  def dispatch({m, v}, value) do
    apply(m, v, [value])
  end

  defp validator_for(prop) do
    conf = Application.get_env(:activity_streams, :validators, %{})

    @defaults
    |> Map.merge(conf)
    |> Map.get(prop)
  end
end
