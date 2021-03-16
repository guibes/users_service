defmodule BroadwayUsersWorker do
  use Broadway

  alias Broadway.Message

  def start_link(_opts) do
    Broadway.start_link(BroadwayUsersWorker,
      name: BroadwayUsersWorker,
      producer: [
        module:
          {BroadwaySQS.Producer,
           queue_url: "https://sqs.amazonaws.com/398206623362/TestQueue",
           config: [
             access_key_id: "AKIAVZNXW32BHLWU7375",
             secret_access_key: "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",
             region: "sa-east-1"
           ]}
      ],
      processors: [
        default: []
      ],
      batchers: [
        default: [
          batch_size: 10,
          batch_timeout: 2000
        ]
      ]
    )
  end

  @impl true
  def handle_message(_, %Message{} = message, _) do
    message
    |> Message.update_data(&process_data/1)
    |> Message.put_batcher(:default)
  end

  defp process_data(data) do
    data
    |> IO.puts()
    # Do some calculations, generate a JSON representation, etc.
  end

  @impl true
  def handle_batch(:sqs, messages, _batch_info, _context) do
    messages
    |> IO.puts()
  end

  @impl true
  def handle_batch(:default, messages, _batch_info, _context) do
    messages
  end


end
