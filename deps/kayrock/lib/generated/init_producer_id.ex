defmodule(Kayrock.InitProducerId) do
  @api :init_producer_id
  @moduledoc "Kayrock-generated module for the Kafka `#{@api}` API\n"
  _ = " THIS CODE IS GENERATED BY KAYROCK"

  (
    @vmin 0
    @vmax 0
  )

  defmodule(V0.Request) do
    @vsn 0
    @api :init_producer_id
    @schema transactional_id: :nullable_string, transaction_timeout_ms: :int32
    @moduledoc "Kayrock-generated request struct for Kafka `#{@api}` v#{@vsn} API\nmessages\n\nThe schema of this API is\n```\n#{
                 inspect(@schema, pretty: true)
               }\n```\n"
    _ = " THIS CODE IS GENERATED BY KAYROCK"

    defstruct(
      transactional_id: nil,
      transaction_timeout_ms: nil,
      correlation_id: nil,
      client_id: nil
    )

    import(Elixir.Kayrock.Serialize)
    @typedoc "Request struct for the Kafka `#{@api}` API v#{@vsn}\n"
    @type t :: %__MODULE__{
            transactional_id: nil | binary(),
            transaction_timeout_ms: nil | integer(),
            correlation_id: nil | integer(),
            client_id: nil | binary()
          }
    @doc "Returns the Kafka API key for this API"
    @spec api_key :: integer
    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:init_producer_id)
    end

    @doc "Returns the API version (#{@vsn}) implemented by this module"
    @spec api_vsn :: integer
    def(api_vsn) do
      0
    end

    @doc "Returns a function that can be used to deserialize the wire response from the\nbroker for this message type\n"
    @spec response_deserializer :: (binary -> {V0.Response.t(), binary})
    def(response_deserializer) do
      &V0.Response.deserialize/1
    end

    @doc "Returns the schema of this message\n\nSee [above](#).\n"
    @spec schema :: term
    def(schema) do
      [transactional_id: :nullable_string, transaction_timeout_ms: :int32]
    end

    @doc "Serialize a message to binary data for transfer to a Kafka broker"
    @spec serialize(t()) :: iodata
    def(serialize(%V0.Request{} = struct)) do
      [
        <<api_key()::16, api_vsn()::16, struct.correlation_id::32,
          byte_size(struct.client_id)::16, struct.client_id::binary>>,
        [
          serialize(:nullable_string, Map.fetch!(struct, :transactional_id)),
          serialize(:int32, Map.fetch!(struct, :transaction_timeout_ms))
        ]
      ]
    end
  end

  defimpl(Elixir.Kayrock.Request, for: V0.Request) do
    def(serialize(%V0.Request{} = struct)) do
      try do
        V0.Request.serialize(struct)
      rescue
        e ->
          reraise(Kayrock.InvalidRequestError, {e, struct}, __STACKTRACE__)
      end
    end

    def(api_vsn(%V0.Request{})) do
      V0.Request.api_vsn()
    end

    def(response_deserializer(%V0.Request{})) do
      V0.Request.response_deserializer()
    end
  end

  (
    @doc "Returns a request struct for this API with the given version"
    @spec get_request_struct(integer) :: request_t
  )

  def(get_request_struct(0)) do
    %V0.Request{}
  end

  defmodule(V0.Response) do
    @vsn 0
    @api :init_producer_id
    @schema throttle_time_ms: :int32,
            error_code: :int16,
            producer_id: :int64,
            producer_epoch: :int16
    @moduledoc "Kayrock-generated response struct for Kafka `#{@api}` v#{@vsn} API\nmessages\n\nThe schema of this API is\n```\n#{
                 inspect(@schema, pretty: true)
               }\n```\n"
    _ = " THIS CODE IS GENERATED BY KAYROCK"

    defstruct(
      throttle_time_ms: nil,
      error_code: nil,
      producer_id: nil,
      producer_epoch: nil,
      correlation_id: nil
    )

    @typedoc "Response struct for the Kafka `#{@api}` API v#{@vsn}\n"
    @type t :: %__MODULE__{
            throttle_time_ms: nil | integer(),
            error_code: nil | integer(),
            producer_id: nil | integer(),
            producer_epoch: nil | integer(),
            correlation_id: integer()
          }
    import(Elixir.Kayrock.Deserialize)
    @doc "Returns the Kafka API key for this API"
    @spec api_key :: integer
    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:init_producer_id)
    end

    @doc "Returns the API version (#{@vsn}) implemented by this module"
    @spec api_vsn :: integer
    def(api_vsn) do
      0
    end

    @doc "Returns the schema of this message\n\nSee [above](#).\n"
    @spec schema :: term
    def(schema) do
      [throttle_time_ms: :int32, error_code: :int16, producer_id: :int64, producer_epoch: :int16]
    end

    @doc "Deserialize data for this version of this API\n"
    @spec deserialize(binary) :: {t(), binary}
    def(deserialize(data)) do
      <<correlation_id::32-signed, rest::binary>> = data

      deserialize_field(
        :root,
        :throttle_time_ms,
        %__MODULE__{correlation_id: correlation_id},
        rest
      )
    end

    defp(deserialize_field(:root, :throttle_time_ms, acc, data)) do
      {val, rest} = deserialize(:int32, data)
      deserialize_field(:root, :error_code, Map.put(acc, :throttle_time_ms, val), rest)
    end

    defp(deserialize_field(:root, :error_code, acc, data)) do
      {val, rest} = deserialize(:int16, data)
      deserialize_field(:root, :producer_id, Map.put(acc, :error_code, val), rest)
    end

    defp(deserialize_field(:root, :producer_id, acc, data)) do
      {val, rest} = deserialize(:int64, data)
      deserialize_field(:root, :producer_epoch, Map.put(acc, :producer_id, val), rest)
    end

    defp(deserialize_field(:root, :producer_epoch, acc, data)) do
      {val, rest} = deserialize(:int16, data)
      deserialize_field(:root, nil, Map.put(acc, :producer_epoch, val), rest)
    end

    defp(deserialize_field(_, nil, acc, rest)) do
      {acc, rest}
    end
  end

  (
    @doc "Deserializes raw wire data for this API with the given version"
    @spec deserialize(integer, binary) :: {response_t, binary}
  )

  def(deserialize(0, data)) do
    V0.Response.deserialize(data)
  end

  (
    @typedoc "Union type for all request structs for this API"
    @type request_t :: Kayrock.InitProducerId.V0.Request.t()
  )

  (
    @typedoc "Union type for all response structs for this API"
    @type response_t :: Kayrock.InitProducerId.V0.Response.t()
  )

  (
    @doc "Returns the minimum version of this API supported by Kayrock (#{@vmin})"
    @spec min_vsn :: integer
    def(min_vsn) do
      0
    end
  )

  (
    @doc "Returns the maximum version of this API supported by Kayrock (#{@vmax})"
    @spec max_vsn :: integer
    def(max_vsn) do
      0
    end
  )
end