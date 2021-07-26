defmodule Mix.Tasks.Kafka.CreateTopics do
  use Mix.Task

  alias KafkaEx.Protocol.CreateTopics.TopicRequest
  alias KafkaEx.Protocol.CreateTopics.ConfigEntry

  @shortdoc "creates topics from a yaml file"
  def run(_) do
    Mix.Task.run("app.start")

    {:ok, topicYaml} = Path.join(File.cwd!(), "topics.yaml") |> YamlElixir.read_from_file()

    {:ok, worker} = KafkaEx.create_worker(:topic_worker)

    topicYaml["topics"] |> Enum.each(fn (topic) -> createTopic(topic["name"], topic["numPartitions"], topic["replicationFactor"], topic["configEntries"], worker) end)

  end

  def createTopic(name, num_partitions, replication_factor, configs, worker) do

    config_entries = Enum.map(configs, fn (config) -> %ConfigEntry{config_name: config["configName"], config_value: config["configValue"]} end  )

    request = %TopicRequest{
      topic: name,
      num_partitions: num_partitions,
      replication_factor: replication_factor,
      replica_assignment: [],
      config_entries: config_entries
    }

    KafkaEx.create_topics([request], worker_name: worker )
    |> case do
      %KafkaEx.Protocol.CreateTopics.Response{
        topic_errors: [ %KafkaEx.Protocol.CreateTopics.TopicError{ error_code: :no_error, topic_name: _}]
      } ->

        IO.puts("created topic #{name}")

      %KafkaEx.Protocol.CreateTopics.Response{
        topic_errors: [%KafkaEx.Protocol.CreateTopics.TopicError{error_code: :topic_already_exists, topic_name: _}]
      } ->

        IO.puts("topic #{name} already exists")

      %KafkaEx.Protocol.CreateTopics.Response{
        topic_errors: [%KafkaEx.Protocol.CreateTopics.TopicError{error_code: _, topic_name: _}]
      } ->

        Mix.raise("Failed to create topic #{name}: #{inspect(%KafkaEx.Protocol.CreateTopics.Response{})}")
    end
  end
end
