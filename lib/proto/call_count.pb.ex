defmodule CallCountMessage do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          clientId: String.t(),
          count: integer
        }

  @derive Jason.Encoder
  defstruct [:clientId, :count]

  field :clientId, 1, type: :string
  field :count, 2, type: :int32
end
