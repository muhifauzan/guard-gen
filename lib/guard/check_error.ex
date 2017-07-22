defmodule GuardGen.CheckError do
  @moduledoc false

  defexception args: nil, arity: nil, check: nil

  def message(%__MODULE__{args: args, arity: arity, check: check}) do
    "undefined or argument error on check #{check}/#{arity} with value #{args}"
  end
end
