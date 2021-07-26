defmodule CallCount.CallCountConsumer do
  use KafkaEx.GenConsumer

  alias KafkaEx.Protocol.Fetch.Message
  alias CallCount.Calls.Call
  alias CallCount.Calls

  require Logger

  # note - messages are delivered in batches
  def handle_message_set(message_set, state) do
    for %Message{value: value , key: key} <- message_set do
      Logger.debug(fn -> "tenant: " <> inspect(key) end)

      callCount = CallCountMessage.decode(value)
      now = Timex.now()

      call = %{
        :tenantId => key,
        :clientId => callCount.clientId,
        :year => now.year,
        :month => now.month,
        :day => now.day,
        :hour => now.hour
      }


      Calls.create_call(call)
      IO.inspect(call)

    end
    {:async_commit, state}
  end
end
