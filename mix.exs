defmodule GuardGen.Mixfile do
  use Mix.Project

  @version "VERSION" |> File.read!() |> String.trim()
  @name "GuardGen"
  @github "https://github.com/muhifauzan/guard-gen"
  @description """
  #{@name} provides macro that can be used as guard test to generate type-checks.
  """

  def project do
    [
      app: :guard_gen,
      version: @version,
      elixir: "~> 1.5",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      dialyzer: [plt_core_path: System.get_env("DIALYXIR_PLT_CORE_PATH")],

      # Docs
      name: @name,
      source_url: @github,
      docs: docs(),

      # Hex
      description: @description,
      package: package(),
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      # Static analyses
      {:dialyxir, "~> 0.5", only: [:dev, :test], runtime: false},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},

      # Docs
      {:ex_doc, "~> 0.14", only: [:dev, :test], runtime: false},

      # Optional
      {:inch_ex, "~> 0.5", only: [:dev, :test], optional: true},
    ]
  end

  def docs do
    [
      source_ref: "v#{@version}",
      main: @name,
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      maintainers: ["Muhammad Hilmy Fauzan"],
      links: %{"GitHub" => @github},
    ]
  end
end
