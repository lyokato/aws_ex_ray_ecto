defmodule AwsExRayEcto.MixProject do
  use Mix.Project

  def project do
    [
      app: :aws_ex_ray_ecto,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:aws_ex_ray, github: "lyokato/aws_ex_ray"}
    ]
  end
end
