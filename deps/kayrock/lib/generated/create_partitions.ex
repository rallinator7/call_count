defmodule(Kayrock.CreatePartitions) do
  @api :create_partitions
  @moduledoc "Kayrock-generated module for the Kafka `#{@api}` API\n"
  _ = " THIS CODE IS GENERATED BY KAYROCK"

  (
    @vmin 0
    @vmax 0
  )

  defmodule(V0.Request) do
    @vsn 0
    @api :create_partitions
    @schema topic_partitions:
              {:array,
               [
                 topic: :string,
                 new_partitions: [count: :int32, assignment: {:array, {:array, :int32}}]
               ]},
            timeout: :int32,
            validate_only: :boolean
    @moduledoc "Kayrock-generated request struct for Kafka `#{@api}` v#{@vsn} API\nmessages\n\nThe schema of this API is\n```\n#{
                 inspect(@schema, pretty: true)
               }\n```\n"
    _ = " THIS CODE IS GENERATED BY KAYROCK"

    defstruct(
      topic_partitions: [],
      timeout: nil,
      validate_only: nil,
      correlation_id: nil,
      client_id: nil
    )

    import(Elixir.Kayrock.Serialize)
    @typedoc "Request struct for the Kafka `#{@api}` API v#{@vsn}\n"
    @type t :: %__MODULE__{
            topic_partitions: [
              %{
                topic: nil | binary(),
                new_partitions: %{count: nil | integer(), assignment: [[nil | integer()]]}
              }
            ],
            timeout: nil | integer(),
            validate_only: nil | integer(),
            correlation_id: nil | integer(),
            client_id: nil | binary()
          }
    @doc "Returns the Kafka API key for this API"
    @spec api_key :: integer
    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:create_partitions)
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
      [
        topic_partitions:
          {:array,
           [
             topic: :string,
             new_partitions: [count: :int32, assignment: {:array, {:array, :int32}}]
           ]},
        timeout: :int32,
        validate_only: :boolean
      ]
    end

    @doc "Serialize a message to binary data for transfer to a Kafka broker"
    @spec serialize(t()) :: iodata
    def(serialize(%V0.Request{} = struct)) do
      [
        <<api_key()::16, api_vsn()::16, struct.correlation_id::32,
          byte_size(struct.client_id)::16, struct.client_id::binary>>,
        [
          case(Map.fetch!(struct, :topic_partitions)) do
            nil ->
              <<-1::32-signed>>

            [] ->
              <<0::32-signed>>

            vals when is_list(vals) ->
              [
                <<length(vals)::32-signed>>,
                for(v <- vals) do
                  [
                    serialize(:string, Map.fetch!(v, :topic)),
                    (
                      v = Map.fetch!(v, :new_partitions)

                      [
                        serialize(:int32, Map.fetch!(v, :count)),
                        case(Map.fetch!(v, :assignment)) do
                          nil ->
                            <<-1::32-signed>>

                          [] ->
                            <<0::32-signed>>

                          vals when is_list(vals) ->
                            [
                              <<length(vals)::32-signed>>,
                              for(v <- vals) do
                                serialize_array(:int32, v)
                              end
                            ]
                        end
                      ]
                    )
                  ]
                end
              ]
          end,
          serialize(:int32, Map.fetch!(struct, :timeout)),
          serialize(:boolean, Map.fetch!(struct, :validate_only))
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
    @api :create_partitions
    @schema throttle_time_ms: :int32,
            topic_errors:
              {:array, [topic: :string, error_code: :int16, error_message: :nullable_string]}
    @moduledoc "Kayrock-generated response struct for Kafka `#{@api}` v#{@vsn} API\nmessages\n\nThe schema of this API is\n```\n#{
                 inspect(@schema, pretty: true)
               }\n```\n"
    _ = " THIS CODE IS GENERATED BY KAYROCK"
    defstruct(throttle_time_ms: nil, topic_errors: [], correlation_id: nil)
    @typedoc "Response struct for the Kafka `#{@api}` API v#{@vsn}\n"
    @type t :: %__MODULE__{
            throttle_time_ms: nil | integer(),
            topic_errors: [
              %{topic: nil | binary(), error_code: nil | integer(), error_message: nil | binary()}
            ],
            correlation_id: integer()
          }
    import(Elixir.Kayrock.Deserialize)
    @doc "Returns the Kafka API key for this API"
    @spec api_key :: integer
    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:create_partitions)
    end

    @doc "Returns the API version (#{@vsn}) implemented by this module"
    @spec api_vsn :: integer
    def(api_vsn) do
      0
    end

    @doc "Returns the schema of this message\n\nSee [above](#).\n"
    @spec schema :: term
    def(schema) do
      [
        throttle_time_ms: :int32,
        topic_errors:
          {:array, [topic: :string, error_code: :int16, error_message: :nullable_string]}
      ]
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
      deserialize_field(:root, :topic_errors, Map.put(acc, :throttle_time_ms, val), rest)
    end

    defp(deserialize_field(:topic_errors, :topic, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:topic_errors, :error_code, Map.put(acc, :topic, val), rest)
    end

    defp(deserialize_field(:topic_errors, :error_code, acc, data)) do
      {val, rest} = deserialize(:int16, data)
      deserialize_field(:topic_errors, :error_message, Map.put(acc, :error_code, val), rest)
    end

    defp(deserialize_field(:topic_errors, :error_message, acc, data)) do
      {val, rest} = deserialize(:nullable_string, data)
      deserialize_field(:topic_errors, nil, Map.put(acc, :error_message, val), rest)
    end

    defp(deserialize_field(:root, :topic_errors, acc, data)) do
      <<num_elements::32-signed, rest::binary>> = data

      {vals, rest} =
        if(num_elements > 0) do
          Enum.reduce(1..num_elements, {[], rest}, fn _ix, {acc, d} ->
            {val, r} = deserialize_field(:topic_errors, :topic, %{}, d)
            {[val | acc], r}
          end)
        else
          {[], rest}
        end

      deserialize_field(:root, nil, Map.put(acc, :topic_errors, Enum.reverse(vals)), rest)
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
    @type request_t :: Kayrock.CreatePartitions.V0.Request.t()
  )

  (
    @typedoc "Union type for all response structs for this API"
    @type response_t :: Kayrock.CreatePartitions.V0.Response.t()
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