defmodule AwsExRay.Ecto.Logger do
  alias AwsExRay.Record.SQL
  alias AwsExRay.Subsegment
  alias AwsExRay.Util

  def log(entry) do
    opts = [
      namespace: :remote,
      tracing_pid: entry.caller_pid
    ]

    case start_subsegment("Ecto", opts) do
      {:error, _reason} ->
        :ok

      {:ok, subsegment} ->
        elapsed_microsec = System.convert_time_unit(entry.query_time, :native, :microsecond)

        elapsed_sec = elapsed_microsec / 1_000_000

        end_time = Util.now()

        start_time = end_time - elapsed_sec

        sql = %SQL{
          sanitized_query: entry.query
          # url: "",
          # connection_string: "",
          # database_type: "",
          # database_version: "",
          # driver_version: "",
          # user: "",
          # preparation: "",
        }

        subsegment
        |> Subsegment.set_start_time(start_time)
        |> Subsegment.set_sql(sql)
        |> AwsExRay.finish_subsegment(end_time)

        :ok
    end
  end

  defp start_subsegment(name, opts) do
    try do
      AwsExRay.start_subsegment(name, opts)
    rescue
      e -> {:error, e}
    end
  end
end
