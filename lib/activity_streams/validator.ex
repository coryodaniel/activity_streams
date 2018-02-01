defmodule ActivityStreams.Validator do
  @moduledoc false

  @spec validate(__MODULE__, list(:atom)) :: :ok | {:error, ActivityStreams.InvalidType.t()}
  def validate(struct, required) do
    %ActivityStreams.InvalidType{data: struct}
    |> check_required_props(required)
    |> validate_properties
    |> case do
      %{errors: []} -> :ok
      invalid -> {:error, invalid}
    end
  end

  defp validate_properties(invalid) do
    struct = invalid.data

    fields_with_values =
      struct
      |> prop_names
      |> Enum.filter(fn field -> Map.get(struct, field) != nil end)

    Enum.reduce(fields_with_values, invalid, fn field, acc ->
      valid = ActivityStreams.PropValidator.validate(field, Map.get(struct, field))

      case valid do
        {:error, msg} -> add_error_message(acc, field, msg)
        _ -> acc
      end
    end)
  end

  defp add_error_message(invalid, field, message) do
    %{invalid | errors: Keyword.put(invalid.errors, field, message)}
  end

  defp check_required_props(invalid, required) do
    struct = invalid.data

    Enum.reduce(required, invalid, fn field, acc ->
      case Map.get(struct, field) do
        nil -> add_error_message(invalid, field, "is required")
        _ -> acc
      end
    end)
  end

  defp prop_names(struct), do: Map.keys(struct) -- [:__struct__]
end
