defmodule Kayrock.BinaryDebugUtil do
  @moduledoc """
  Functions to help debugging binaries
  """

  def print_with_fields(data, fields) when is_binary(data) and is_list(fields) do
    {parsed_fields_reversed, remainder} =
      Enum.reduce(fields, {[], data}, fn field, {acc, remains} ->
        {val, rest} = deserialize_field(field, remains)
        {[val | acc], rest}
      end)

    {Enum.reverse(parsed_fields_reversed), remainder}
  end

  defp deserialize_field({name, field}, data) do
    {val, rest} = deserialize_field(field, data)
    {{name, val}, rest}
  end

  defp deserialize_field(field, data) when is_atom(field) do
    Kayrock.Deserialize.deserialize(field, data)
  end
end
