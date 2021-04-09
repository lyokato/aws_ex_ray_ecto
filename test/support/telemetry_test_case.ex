defmodule TelemetryTestCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      def telemetry_handlers_ids do
        :telemetry.list_handlers([])
        |> Enum.map(fn h -> h.id end)
      end

      def detach_all_handlers() do
        Enum.each(:telemetry.list_handlers([]), fn %{id: id} ->
          :telemetry.detach(id)
        end)
      end
    end
  end
end
