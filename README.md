# AwsExRay - Ecto Support

## NOT STABLE YET

Please wait version 1.0.0 released.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `aws_ex_ray_ecto` to your list of dependencies in `mix.exs`:

```elixir
def application do
  [
    extra_applications: [
      :logger,
      :aws_ex_ray
      # ...
    ],
    mod {MyApp.Supervisor, []}
  ]
end

def deps do
  [
    {:aws_ex_ray, "~> 0.1"},
    {:aws_ex_ray_ecto, "~> 0.1.4"},
     # ...
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/aws_ex_ray_ecto](https://hexdocs.pm/aws_ex_ray_ecto).

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

## SEE ALSO

- Core: https://github.com/lyokato/aws_ex_ray
- Plug Support: https://github.com/lyokato/aws_ex_ray_plug
- HTTPoison Support: https://github.com/lyokato/aws_ex_ray_httpoison
- ExAws Support: https://github.com/lyokato/aws_ex_ray_ex_aws

