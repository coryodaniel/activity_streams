defmodule ActivityStreams.InvalidType do
  @moduledoc """
  """

  @enforce_keys [:data]
  @type t :: %__MODULE__{
          errors: keyword(String.t()),
          data: struct()
        }

  defstruct data: nil, errors: []
end
