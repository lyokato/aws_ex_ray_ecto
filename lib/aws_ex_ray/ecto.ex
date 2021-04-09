defmodule AwsExRay.Ecto do
  @moduledoc ~S"""

  ## USAGE

  ### with Ecto >= 3 - Telemetry based instrumenter

  In your Application file

  ```elixir
  defmodule MyApp.Application do
  use Application

  @impl Application
  def start(_type, _opts) do
    ...
    AwsExRay.Ecto.Instrumenter.attach(ecto_app_name)
    ...
  end
  end
  ```

  `ecto_app_name` can be found in your `Repo` file as `:otp_app` value

  ```elixir
  defmodule MyApp.Repo do
  use Ecto.Repo, otp_app: :my_app, adapter: Ecto.Adapters.MyXQL
  end
  ```

  ### with Ecto < 3 - Logger based

  In your config file,
  put `AwsExRay.Ecto.Logger` into Ecto's `:loggers` setting.

  ```elixir
  config :my_app, MyApp.EctoRepo,
  adapter: Ecto.Adapters.MySQL,
  hostname: "example.org",
  port:     "3306",
  database: "my_db",
  username: "foo",
  password: "bar",
  loggers:  [Ecto.LogEntry, AwsExRay.Ecto.Logger]
  ```

  Then automatically record subsegment if queries called on the tracing process.
  """
end
