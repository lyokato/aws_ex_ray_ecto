defmodule AwsExRay.Ecto.Instrumenter do
  alias AwsExRay.{Record.SQL, Subsegment}

  def attach(app_name) do
    :telemetry.attach(
      "aws-ex_ray-ecto",
      [app_name, :repo, :query],
      fn event, measurements, metadata, _config ->
        start_tracing(event, measurements, metadata)
      end,
      %{}
    )
  end

  def start_tracing([app_name, :repo, :query], %{query_time: query_time}, %{query: query}) do
    case start_subsegment("#{app_name}-repo", namespace: :remote) do
      {:ok, subsegment} ->
        elapsed_sec = System.convert_time_unit(query_time, :native, :microsecond) / 1_000_000
        end_time = (DateTime.utc_now() |> DateTime.to_unix(:microsecond)) / 1_000_000

        start_time = end_time - elapsed_sec

        sql = %SQL{
          sanitized_query: query
        }

        subsegment =
          subsegment
          |> Subsegment.set_start_time(start_time)
          |> Subsegment.set_sql(sql)

        AwsExRay.finish_subsegment(subsegment, end_time)

        {:ok, subsegment}

      {:error, error} ->
        {:error, error}
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
