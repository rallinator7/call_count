defmodule(Kayrock.JoinGroup) do
  @api :join_group
  @moduledoc "Kayrock-generated module for the Kafka `#{@api}` API\n"
  _ = " THIS CODE IS GENERATED BY KAYROCK"

  (
    @vmin 0
    @vmax 2
  )

  defmodule(V0.Request) do
    @vsn 0
    @api :join_group
    @schema group_id: :string,
            session_timeout: :int32,
            member_id: :string,
            protocol_type: :string,
            group_protocols: {:array, [protocol_name: :string, protocol_metadata: :bytes]}
    @moduledoc "Kayrock-generated request struct for Kafka `#{@api}` v#{@vsn} API\nmessages\n\nThe schema of this API is\n```\n#{
                 inspect(@schema, pretty: true)
               }\n```\n"
    _ = " THIS CODE IS GENERATED BY KAYROCK"

    defstruct(
      group_id: nil,
      session_timeout: nil,
      member_id: nil,
      protocol_type: nil,
      group_protocols: [],
      correlation_id: nil,
      client_id: nil
    )

    import(Elixir.Kayrock.Serialize)
    @typedoc "Request struct for the Kafka `#{@api}` API v#{@vsn}\n"
    @type t :: %__MODULE__{
            group_id: nil | binary(),
            session_timeout: nil | integer(),
            member_id: nil | binary(),
            protocol_type: nil | binary(),
            group_protocols: [
              %{protocol_name: nil | binary(), protocol_metadata: nil | bitstring()}
            ],
            correlation_id: nil | integer(),
            client_id: nil | binary()
          }
    @doc "Returns the Kafka API key for this API"
    @spec api_key :: integer
    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:join_group)
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
        group_id: :string,
        session_timeout: :int32,
        member_id: :string,
        protocol_type: :string,
        group_protocols: {:array, [protocol_name: :string, protocol_metadata: :bytes]}
      ]
    end

    @doc "Serialize a message to binary data for transfer to a Kafka broker"
    @spec serialize(t()) :: iodata
    def(serialize(%V0.Request{} = struct)) do
      [
        <<api_key()::16, api_vsn()::16, struct.correlation_id::32,
          byte_size(struct.client_id)::16, struct.client_id::binary>>,
        [
          serialize(:string, Map.fetch!(struct, :group_id)),
          serialize(:int32, Map.fetch!(struct, :session_timeout)),
          serialize(:string, Map.fetch!(struct, :member_id)),
          serialize(:string, Map.fetch!(struct, :protocol_type)),
          case(Map.fetch!(struct, :group_protocols)) do
            nil ->
              <<-1::32-signed>>

            [] ->
              <<0::32-signed>>

            vals when is_list(vals) ->
              [
                <<length(vals)::32-signed>>,
                for(v <- vals) do
                  [
                    serialize(:string, Map.fetch!(v, :protocol_name)),
                    case(Map.fetch!(v, :protocol_metadata)) do
                      %Kayrock.GroupProtocolMetadata{} = m ->
                        Kayrock.Serialize.serialize(
                          :iodata_bytes,
                          Kayrock.GroupProtocolMetadata.serialize(m)
                        )

                      b when is_binary(b) ->
                        Kayrock.Serialize.serialize(:bytes, b)
                    end
                  ]
                end
              ]
          end
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

  defmodule(V1.Request) do
    @vsn 1
    @api :join_group
    @schema group_id: :string,
            session_timeout: :int32,
            rebalance_timeout: :int32,
            member_id: :string,
            protocol_type: :string,
            group_protocols: {:array, [protocol_name: :string, protocol_metadata: :bytes]}
    @moduledoc "Kayrock-generated request struct for Kafka `#{@api}` v#{@vsn} API\nmessages\n\nThe schema of this API is\n```\n#{
                 inspect(@schema, pretty: true)
               }\n```\n"
    _ = " THIS CODE IS GENERATED BY KAYROCK"

    defstruct(
      group_id: nil,
      session_timeout: nil,
      rebalance_timeout: nil,
      member_id: nil,
      protocol_type: nil,
      group_protocols: [],
      correlation_id: nil,
      client_id: nil
    )

    import(Elixir.Kayrock.Serialize)
    @typedoc "Request struct for the Kafka `#{@api}` API v#{@vsn}\n"
    @type t :: %__MODULE__{
            group_id: nil | binary(),
            session_timeout: nil | integer(),
            rebalance_timeout: nil | integer(),
            member_id: nil | binary(),
            protocol_type: nil | binary(),
            group_protocols: [
              %{protocol_name: nil | binary(), protocol_metadata: nil | bitstring()}
            ],
            correlation_id: nil | integer(),
            client_id: nil | binary()
          }
    @doc "Returns the Kafka API key for this API"
    @spec api_key :: integer
    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:join_group)
    end

    @doc "Returns the API version (#{@vsn}) implemented by this module"
    @spec api_vsn :: integer
    def(api_vsn) do
      1
    end

    @doc "Returns a function that can be used to deserialize the wire response from the\nbroker for this message type\n"
    @spec response_deserializer :: (binary -> {V1.Response.t(), binary})
    def(response_deserializer) do
      &V1.Response.deserialize/1
    end

    @doc "Returns the schema of this message\n\nSee [above](#).\n"
    @spec schema :: term
    def(schema) do
      [
        group_id: :string,
        session_timeout: :int32,
        rebalance_timeout: :int32,
        member_id: :string,
        protocol_type: :string,
        group_protocols: {:array, [protocol_name: :string, protocol_metadata: :bytes]}
      ]
    end

    @doc "Serialize a message to binary data for transfer to a Kafka broker"
    @spec serialize(t()) :: iodata
    def(serialize(%V1.Request{} = struct)) do
      [
        <<api_key()::16, api_vsn()::16, struct.correlation_id::32,
          byte_size(struct.client_id)::16, struct.client_id::binary>>,
        [
          serialize(:string, Map.fetch!(struct, :group_id)),
          serialize(:int32, Map.fetch!(struct, :session_timeout)),
          serialize(:int32, Map.fetch!(struct, :rebalance_timeout)),
          serialize(:string, Map.fetch!(struct, :member_id)),
          serialize(:string, Map.fetch!(struct, :protocol_type)),
          case(Map.fetch!(struct, :group_protocols)) do
            nil ->
              <<-1::32-signed>>

            [] ->
              <<0::32-signed>>

            vals when is_list(vals) ->
              [
                <<length(vals)::32-signed>>,
                for(v <- vals) do
                  [
                    serialize(:string, Map.fetch!(v, :protocol_name)),
                    case(Map.fetch!(v, :protocol_metadata)) do
                      %Kayrock.GroupProtocolMetadata{} = m ->
                        Kayrock.Serialize.serialize(
                          :iodata_bytes,
                          Kayrock.GroupProtocolMetadata.serialize(m)
                        )

                      b when is_binary(b) ->
                        Kayrock.Serialize.serialize(:bytes, b)
                    end
                  ]
                end
              ]
          end
        ]
      ]
    end
  end

  defimpl(Elixir.Kayrock.Request, for: V1.Request) do
    def(serialize(%V1.Request{} = struct)) do
      try do
        V1.Request.serialize(struct)
      rescue
        e ->
          reraise(Kayrock.InvalidRequestError, {e, struct}, __STACKTRACE__)
      end
    end

    def(api_vsn(%V1.Request{})) do
      V1.Request.api_vsn()
    end

    def(response_deserializer(%V1.Request{})) do
      V1.Request.response_deserializer()
    end
  end

  defmodule(V2.Request) do
    @vsn 2
    @api :join_group
    @schema group_id: :string,
            session_timeout: :int32,
            rebalance_timeout: :int32,
            member_id: :string,
            protocol_type: :string,
            group_protocols: {:array, [protocol_name: :string, protocol_metadata: :bytes]}
    @moduledoc "Kayrock-generated request struct for Kafka `#{@api}` v#{@vsn} API\nmessages\n\nThe schema of this API is\n```\n#{
                 inspect(@schema, pretty: true)
               }\n```\n"
    _ = " THIS CODE IS GENERATED BY KAYROCK"

    defstruct(
      group_id: nil,
      session_timeout: nil,
      rebalance_timeout: nil,
      member_id: nil,
      protocol_type: nil,
      group_protocols: [],
      correlation_id: nil,
      client_id: nil
    )

    import(Elixir.Kayrock.Serialize)
    @typedoc "Request struct for the Kafka `#{@api}` API v#{@vsn}\n"
    @type t :: %__MODULE__{
            group_id: nil | binary(),
            session_timeout: nil | integer(),
            rebalance_timeout: nil | integer(),
            member_id: nil | binary(),
            protocol_type: nil | binary(),
            group_protocols: [
              %{protocol_name: nil | binary(), protocol_metadata: nil | bitstring()}
            ],
            correlation_id: nil | integer(),
            client_id: nil | binary()
          }
    @doc "Returns the Kafka API key for this API"
    @spec api_key :: integer
    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:join_group)
    end

    @doc "Returns the API version (#{@vsn}) implemented by this module"
    @spec api_vsn :: integer
    def(api_vsn) do
      2
    end

    @doc "Returns a function that can be used to deserialize the wire response from the\nbroker for this message type\n"
    @spec response_deserializer :: (binary -> {V2.Response.t(), binary})
    def(response_deserializer) do
      &V2.Response.deserialize/1
    end

    @doc "Returns the schema of this message\n\nSee [above](#).\n"
    @spec schema :: term
    def(schema) do
      [
        group_id: :string,
        session_timeout: :int32,
        rebalance_timeout: :int32,
        member_id: :string,
        protocol_type: :string,
        group_protocols: {:array, [protocol_name: :string, protocol_metadata: :bytes]}
      ]
    end

    @doc "Serialize a message to binary data for transfer to a Kafka broker"
    @spec serialize(t()) :: iodata
    def(serialize(%V2.Request{} = struct)) do
      [
        <<api_key()::16, api_vsn()::16, struct.correlation_id::32,
          byte_size(struct.client_id)::16, struct.client_id::binary>>,
        [
          serialize(:string, Map.fetch!(struct, :group_id)),
          serialize(:int32, Map.fetch!(struct, :session_timeout)),
          serialize(:int32, Map.fetch!(struct, :rebalance_timeout)),
          serialize(:string, Map.fetch!(struct, :member_id)),
          serialize(:string, Map.fetch!(struct, :protocol_type)),
          case(Map.fetch!(struct, :group_protocols)) do
            nil ->
              <<-1::32-signed>>

            [] ->
              <<0::32-signed>>

            vals when is_list(vals) ->
              [
                <<length(vals)::32-signed>>,
                for(v <- vals) do
                  [
                    serialize(:string, Map.fetch!(v, :protocol_name)),
                    case(Map.fetch!(v, :protocol_metadata)) do
                      %Kayrock.GroupProtocolMetadata{} = m ->
                        Kayrock.Serialize.serialize(
                          :iodata_bytes,
                          Kayrock.GroupProtocolMetadata.serialize(m)
                        )

                      b when is_binary(b) ->
                        Kayrock.Serialize.serialize(:bytes, b)
                    end
                  ]
                end
              ]
          end
        ]
      ]
    end
  end

  defimpl(Elixir.Kayrock.Request, for: V2.Request) do
    def(serialize(%V2.Request{} = struct)) do
      try do
        V2.Request.serialize(struct)
      rescue
        e ->
          reraise(Kayrock.InvalidRequestError, {e, struct}, __STACKTRACE__)
      end
    end

    def(api_vsn(%V2.Request{})) do
      V2.Request.api_vsn()
    end

    def(response_deserializer(%V2.Request{})) do
      V2.Request.response_deserializer()
    end
  end

  (
    @doc "Returns a request struct for this API with the given version"
    @spec get_request_struct(integer) :: request_t
  )

  def(get_request_struct(0)) do
    %V0.Request{}
  end

  def(get_request_struct(1)) do
    %V1.Request{}
  end

  def(get_request_struct(2)) do
    %V2.Request{}
  end

  defmodule(V0.Response) do
    @vsn 0
    @api :join_group
    @schema error_code: :int16,
            generation_id: :int32,
            group_protocol: :string,
            leader_id: :string,
            member_id: :string,
            members: {:array, [member_id: :string, member_metadata: :bytes]}
    @moduledoc "Kayrock-generated response struct for Kafka `#{@api}` v#{@vsn} API\nmessages\n\nThe schema of this API is\n```\n#{
                 inspect(@schema, pretty: true)
               }\n```\n"
    _ = " THIS CODE IS GENERATED BY KAYROCK"

    defstruct(
      error_code: nil,
      generation_id: nil,
      group_protocol: nil,
      leader_id: nil,
      member_id: nil,
      members: [],
      correlation_id: nil
    )

    @typedoc "Response struct for the Kafka `#{@api}` API v#{@vsn}\n"
    @type t :: %__MODULE__{
            error_code: nil | integer(),
            generation_id: nil | integer(),
            group_protocol: nil | binary(),
            leader_id: nil | binary(),
            member_id: nil | binary(),
            members: [%{member_id: nil | binary(), member_metadata: nil | bitstring()}],
            correlation_id: integer()
          }
    import(Elixir.Kayrock.Deserialize)
    @doc "Returns the Kafka API key for this API"
    @spec api_key :: integer
    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:join_group)
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
        error_code: :int16,
        generation_id: :int32,
        group_protocol: :string,
        leader_id: :string,
        member_id: :string,
        members: {:array, [member_id: :string, member_metadata: :bytes]}
      ]
    end

    @doc "Deserialize data for this version of this API\n"
    @spec deserialize(binary) :: {t(), binary}
    def(deserialize(data)) do
      <<correlation_id::32-signed, rest::binary>> = data
      deserialize_field(:root, :error_code, %__MODULE__{correlation_id: correlation_id}, rest)
    end

    defp(deserialize_field(:root, :error_code, acc, data)) do
      {val, rest} = deserialize(:int16, data)
      deserialize_field(:root, :generation_id, Map.put(acc, :error_code, val), rest)
    end

    defp(deserialize_field(:root, :generation_id, acc, data)) do
      {val, rest} = deserialize(:int32, data)
      deserialize_field(:root, :group_protocol, Map.put(acc, :generation_id, val), rest)
    end

    defp(deserialize_field(:root, :group_protocol, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:root, :leader_id, Map.put(acc, :group_protocol, val), rest)
    end

    defp(deserialize_field(:root, :leader_id, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:root, :member_id, Map.put(acc, :leader_id, val), rest)
    end

    defp(deserialize_field(:root, :member_id, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:root, :members, Map.put(acc, :member_id, val), rest)
    end

    defp(deserialize_field(:members, :member_id, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:members, :member_metadata, Map.put(acc, :member_id, val), rest)
    end

    defp(deserialize_field(:members, :member_metadata, acc, data)) do
      {val, rest} = deserialize(:bytes, data)
      deserialize_field(:members, nil, Map.put(acc, :member_metadata, val), rest)
    end

    defp(deserialize_field(:root, :members, acc, data)) do
      <<num_elements::32-signed, rest::binary>> = data

      {vals, rest} =
        if(num_elements > 0) do
          Enum.reduce(1..num_elements, {[], rest}, fn _ix, {acc, d} ->
            {val, r} = deserialize_field(:members, :member_id, %{}, d)
            {[val | acc], r}
          end)
        else
          {[], rest}
        end

      deserialize_field(:root, nil, Map.put(acc, :members, Enum.reverse(vals)), rest)
    end

    defp(deserialize_field(_, nil, acc, rest)) do
      {acc, rest}
    end
  end

  defmodule(V1.Response) do
    @vsn 1
    @api :join_group
    @schema error_code: :int16,
            generation_id: :int32,
            group_protocol: :string,
            leader_id: :string,
            member_id: :string,
            members: {:array, [member_id: :string, member_metadata: :bytes]}
    @moduledoc "Kayrock-generated response struct for Kafka `#{@api}` v#{@vsn} API\nmessages\n\nThe schema of this API is\n```\n#{
                 inspect(@schema, pretty: true)
               }\n```\n"
    _ = " THIS CODE IS GENERATED BY KAYROCK"

    defstruct(
      error_code: nil,
      generation_id: nil,
      group_protocol: nil,
      leader_id: nil,
      member_id: nil,
      members: [],
      correlation_id: nil
    )

    @typedoc "Response struct for the Kafka `#{@api}` API v#{@vsn}\n"
    @type t :: %__MODULE__{
            error_code: nil | integer(),
            generation_id: nil | integer(),
            group_protocol: nil | binary(),
            leader_id: nil | binary(),
            member_id: nil | binary(),
            members: [%{member_id: nil | binary(), member_metadata: nil | bitstring()}],
            correlation_id: integer()
          }
    import(Elixir.Kayrock.Deserialize)
    @doc "Returns the Kafka API key for this API"
    @spec api_key :: integer
    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:join_group)
    end

    @doc "Returns the API version (#{@vsn}) implemented by this module"
    @spec api_vsn :: integer
    def(api_vsn) do
      1
    end

    @doc "Returns the schema of this message\n\nSee [above](#).\n"
    @spec schema :: term
    def(schema) do
      [
        error_code: :int16,
        generation_id: :int32,
        group_protocol: :string,
        leader_id: :string,
        member_id: :string,
        members: {:array, [member_id: :string, member_metadata: :bytes]}
      ]
    end

    @doc "Deserialize data for this version of this API\n"
    @spec deserialize(binary) :: {t(), binary}
    def(deserialize(data)) do
      <<correlation_id::32-signed, rest::binary>> = data
      deserialize_field(:root, :error_code, %__MODULE__{correlation_id: correlation_id}, rest)
    end

    defp(deserialize_field(:root, :error_code, acc, data)) do
      {val, rest} = deserialize(:int16, data)
      deserialize_field(:root, :generation_id, Map.put(acc, :error_code, val), rest)
    end

    defp(deserialize_field(:root, :generation_id, acc, data)) do
      {val, rest} = deserialize(:int32, data)
      deserialize_field(:root, :group_protocol, Map.put(acc, :generation_id, val), rest)
    end

    defp(deserialize_field(:root, :group_protocol, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:root, :leader_id, Map.put(acc, :group_protocol, val), rest)
    end

    defp(deserialize_field(:root, :leader_id, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:root, :member_id, Map.put(acc, :leader_id, val), rest)
    end

    defp(deserialize_field(:root, :member_id, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:root, :members, Map.put(acc, :member_id, val), rest)
    end

    defp(deserialize_field(:members, :member_id, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:members, :member_metadata, Map.put(acc, :member_id, val), rest)
    end

    defp(deserialize_field(:members, :member_metadata, acc, data)) do
      {val, rest} = deserialize(:bytes, data)
      deserialize_field(:members, nil, Map.put(acc, :member_metadata, val), rest)
    end

    defp(deserialize_field(:root, :members, acc, data)) do
      <<num_elements::32-signed, rest::binary>> = data

      {vals, rest} =
        if(num_elements > 0) do
          Enum.reduce(1..num_elements, {[], rest}, fn _ix, {acc, d} ->
            {val, r} = deserialize_field(:members, :member_id, %{}, d)
            {[val | acc], r}
          end)
        else
          {[], rest}
        end

      deserialize_field(:root, nil, Map.put(acc, :members, Enum.reverse(vals)), rest)
    end

    defp(deserialize_field(_, nil, acc, rest)) do
      {acc, rest}
    end
  end

  defmodule(V2.Response) do
    @vsn 2
    @api :join_group
    @schema throttle_time_ms: :int32,
            error_code: :int16,
            generation_id: :int32,
            group_protocol: :string,
            leader_id: :string,
            member_id: :string,
            members: {:array, [member_id: :string, member_metadata: :bytes]}
    @moduledoc "Kayrock-generated response struct for Kafka `#{@api}` v#{@vsn} API\nmessages\n\nThe schema of this API is\n```\n#{
                 inspect(@schema, pretty: true)
               }\n```\n"
    _ = " THIS CODE IS GENERATED BY KAYROCK"

    defstruct(
      throttle_time_ms: nil,
      error_code: nil,
      generation_id: nil,
      group_protocol: nil,
      leader_id: nil,
      member_id: nil,
      members: [],
      correlation_id: nil
    )

    @typedoc "Response struct for the Kafka `#{@api}` API v#{@vsn}\n"
    @type t :: %__MODULE__{
            throttle_time_ms: nil | integer(),
            error_code: nil | integer(),
            generation_id: nil | integer(),
            group_protocol: nil | binary(),
            leader_id: nil | binary(),
            member_id: nil | binary(),
            members: [%{member_id: nil | binary(), member_metadata: nil | bitstring()}],
            correlation_id: integer()
          }
    import(Elixir.Kayrock.Deserialize)
    @doc "Returns the Kafka API key for this API"
    @spec api_key :: integer
    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:join_group)
    end

    @doc "Returns the API version (#{@vsn}) implemented by this module"
    @spec api_vsn :: integer
    def(api_vsn) do
      2
    end

    @doc "Returns the schema of this message\n\nSee [above](#).\n"
    @spec schema :: term
    def(schema) do
      [
        throttle_time_ms: :int32,
        error_code: :int16,
        generation_id: :int32,
        group_protocol: :string,
        leader_id: :string,
        member_id: :string,
        members: {:array, [member_id: :string, member_metadata: :bytes]}
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
      deserialize_field(:root, :error_code, Map.put(acc, :throttle_time_ms, val), rest)
    end

    defp(deserialize_field(:root, :error_code, acc, data)) do
      {val, rest} = deserialize(:int16, data)
      deserialize_field(:root, :generation_id, Map.put(acc, :error_code, val), rest)
    end

    defp(deserialize_field(:root, :generation_id, acc, data)) do
      {val, rest} = deserialize(:int32, data)
      deserialize_field(:root, :group_protocol, Map.put(acc, :generation_id, val), rest)
    end

    defp(deserialize_field(:root, :group_protocol, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:root, :leader_id, Map.put(acc, :group_protocol, val), rest)
    end

    defp(deserialize_field(:root, :leader_id, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:root, :member_id, Map.put(acc, :leader_id, val), rest)
    end

    defp(deserialize_field(:root, :member_id, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:root, :members, Map.put(acc, :member_id, val), rest)
    end

    defp(deserialize_field(:members, :member_id, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:members, :member_metadata, Map.put(acc, :member_id, val), rest)
    end

    defp(deserialize_field(:members, :member_metadata, acc, data)) do
      {val, rest} = deserialize(:bytes, data)
      deserialize_field(:members, nil, Map.put(acc, :member_metadata, val), rest)
    end

    defp(deserialize_field(:root, :members, acc, data)) do
      <<num_elements::32-signed, rest::binary>> = data

      {vals, rest} =
        if(num_elements > 0) do
          Enum.reduce(1..num_elements, {[], rest}, fn _ix, {acc, d} ->
            {val, r} = deserialize_field(:members, :member_id, %{}, d)
            {[val | acc], r}
          end)
        else
          {[], rest}
        end

      deserialize_field(:root, nil, Map.put(acc, :members, Enum.reverse(vals)), rest)
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

  def(deserialize(1, data)) do
    V1.Response.deserialize(data)
  end

  def(deserialize(2, data)) do
    V2.Response.deserialize(data)
  end

  (
    @typedoc "Union type for all request structs for this API"
    @type request_t ::
            Kayrock.JoinGroup.V2.Request.t()
            | Kayrock.JoinGroup.V1.Request.t()
            | Kayrock.JoinGroup.V0.Request.t()
  )

  (
    @typedoc "Union type for all response structs for this API"
    @type response_t ::
            Kayrock.JoinGroup.V2.Response.t()
            | Kayrock.JoinGroup.V1.Response.t()
            | Kayrock.JoinGroup.V0.Response.t()
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
      2
    end
  )
end