defmodule AwsExRayEcto.MixProject do
  use Mix.Project

  def project do
    [
      app: :aws_ex_ray_ecto,
      version: "0.2.0",
      elixir: "~> 1.6",
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:aws_ex_ray, "~> 0.1"},
      {:telemetry, "~> 0.4"},
      {:ex_doc, "~> 0.23.0", only: :dev, runtime: false}
    ]
  end

  defp package() do
    [
      description: "AWS X-Ray reporter Ecto support",
      licenses: ["MIT"],
      links: %{
        "Github" => "https://github.com/lyokato/aws_ex_ray_ecto",
        "Docs" => "https://hexdocs.pm/aws_ex_ray_ecto"
      },
      maintainers: ["Lyo Kato"]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
