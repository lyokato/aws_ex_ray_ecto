defmodule AwsExRayEctoInstrumenterTest do
  use ExUnit.Case
  use TelemetryTestCase
  alias AwsExRay.Ecto.Instrumenter

  describe "attach/1" do
    test "should register a telemetry handler" do
      Instrumenter.attach(:test_prefix)

      assert "aws-ex_ray-ecto" in telemetry_handlers_ids()
    end
  end

  describe "start_tracing/2" do
    @event_name [:test_app, :repo, :query]
    @test_sql_query "SELECT something FROM things"

    def start_tracing() do
      segment = AwsExRay.start_tracing(AwsExRay.Trace.new(), "test-tracing")
      on_exit(fn -> AwsExRay.finish_tracing(segment) end)
    end

    test "returns ok and segment when called within a tracing" do
      start_tracing()

      {:ok, subsegment} =
        Instrumenter.start_tracing(@event_name, %{query_time: 0}, %{query: @test_sql_query})

      assert %AwsExRay.Subsegment{
               segment: %AwsExRay.Segment{
                 name: "test_app-repo"
               },
               sql: %AwsExRay.Record.SQL{
                 sanitized_query: @test_sql_query
               }
             } = subsegment
    end

    test "traces query_time" do
      start_tracing()
      query_time_secs = 666
      query_time_native = System.convert_time_unit(query_time_secs, :second, :native)

      {:ok, subsegment} =
        Instrumenter.start_tracing(@event_name, %{query_time: query_time_native}, %{query: "ok"})

      %AwsExRay.Subsegment{
        segment: %AwsExRay.Segment{
          start_time: start_time
        }
      } = subsegment

      now = (DateTime.utc_now() |> DateTime.to_unix(:microsecond)) / 1_000_000
      assert start_time <= now - query_time_secs
      assert is_float(start_time)
    end

    test "returns error when called outside tracing" do
      assert {:error, :out_of_xray} =
               Instrumenter.start_tracing(@event_name, %{query_time: 666}, %{
                 query: @test_sql_query
               })
    end
  end
end
