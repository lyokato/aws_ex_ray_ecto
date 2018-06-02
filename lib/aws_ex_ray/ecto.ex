defmodule AwsExRay.Ecto do

  @moduledoc ~S"""

  ## USAGE

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
