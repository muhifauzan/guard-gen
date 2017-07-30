defmodule GuardGen do
  @moduledoc """
  GuardGen provides macro that can be used as guard test to generates
  type-checks.

      iex> require GuardGen
      iex> GuardGen.is_valid(is_atom: :atom)
      true

  See `is_valid/1`
  """

  alias GuardGen.CheckError

  @type checklist :: keyword

  @keys Application.get_env(:guard_gen, :original_keys)
  @original_keys @keys -- [:is_list, :in]
  @modified_keys Application.get_env(:guard_gen, :modified_keys)

  @doc """
  Returns true if all type-checks evaluation are true. All type-checks provided
  by `Kernel` can be used as `checklist`. You can also use `Kernel.in/2` inside
  checklist. Multiple type-checks is supported in addition to single type-check
  using modified keys by changing the prefix from `is_` to `are_` followed by the
  plural form of the word.

  ## Arguments

    * `checklist` - Keyword of type-checks that will get evaluated.

  ## Examples

  With single type-check, you write the type-check as you would when using
  `Kernel` type-checks. You write the function as a the key and the argument as
  the value.

      iex> require GuardGen
      iex> GuardGen.is_valid(is_atom: :atom)
      true

  With multiple type-checks, you write the type-check using modified keys by
  changing the prefix from `is_` to `are_` followed by the plural form of the
  word.

      iex> require GuardGen
      iex> GuardGen.is_valid(are_atoms: [:a, :b, :c])
      true

  You can combine the type-checks in single form or multiple form or both.

      iex> require GuardGen
      iex> GuardGen.is_valid(is_atom: :atom, are_atoms: [:a, :b, :c])
      true

  With type-check that takes two arguments, you pass the argument in a list. For
  example when using `Kernel.is_function/2`.

      iex> require GuardGen
      iex> GuardGen.is_valid(is_function: [fn x -> x end, 1])
      true

  With `Kernel.in/2` in single and multiple form.

      iex> require GuardGen
      iex> a = 1
      iex> b = [1, 2, 3]
      iex> GuardGen.is_valid(in: [a, b])
      true
      iex> GuardGen.is_valid(ins: [[1, [1, 2, 3]], [2, [1, 2, 3]]])
      true

  You can also combine `Kernel.in/2` with other type-checks.

      iex> require GuardGen
      iex> GuardGen.is_valid(is_atom: :atom, in: [1, [1, 2, 3]])
      true

  ## Notes

  There's a limitation with check that takes two arguments like `is_function/2`
  and `in/2`. You can't pass the whole arguments as a variable. If you do so, it
  will get evaluated with its single argument counterpart or raising
  `GuardGen.CheckError` due to its check is not available.

      iex> require GuardGen
      iex> var = [fn x -> x end, 1]
      iex> GuardGen.is_valid(is_function: var)
      false
      iex> var1 = fn x -> x end
      iex> GuardGen.is_valid(is_function: [var1, 1])
      true
      iex> var2 = 1
      iex> GuardGen.is_valid(is_function: [fn x -> x end, var2])
      true
      iex> GuardGen.is_valid(is_function: [var1, var2])
      true

  Allowed in guard tests.
  """
  @spec is_valid(checklist) :: boolean
  defmacro is_valid(checklist) do
    checks_ast(checklist)
  end

  defp checks_ast(checklist), do: checks_ast(checklist, true)

  defp checks_ast([], ast), do: ast
  defp checks_ast([{:is_function = atom, [hd, tl | []]} | tail], ast) do
    checks_ast(tail, check_ast(:and, ast, check_ast(atom, hd, tl)))
  end
  defp checks_ast([{:is_list = atom, arg} | tail], ast) do
    checks_ast(tail, check_ast(:and, ast, check_ast(atom, arg)))
  end
  defp checks_ast([{:in = atom, [hd, tl | []]} | tail], ast) do
    checks_ast(tail, check_ast(:and, ast, check_ast(atom, hd, tl)))
  end
  defp checks_ast([{atom, arg} | tail], ast)
  when atom in @original_keys do
    checks_ast(tail, check_ast(:and, ast, check_ast(atom, arg)))
  end
  defp checks_ast([{atom, args} | tail], ast)
  when atom in @modified_keys and is_list(args) and length(args) >= 1 do
    atom = plural_to_singular_key(atom)

    checks_ast(tail,
      check_ast(:and, ast, checks_ast(checklist(atom, args), true)))
  end
  defp checks_ast([{atom, args} | _tail], _ast) do
    arity =
      case is_list(args) do
        true -> length(args)
        _ -> 1
      end

    raise CheckError, args: Macro.to_string(args), arity: arity, check: atom
  end

  defp check_ast(atom, arg), do: quote do: unquote(atom)(unquote(arg))

  defp check_ast(atom, arg1, arg2) do
    quote do: unquote(atom)(unquote(arg1), unquote(arg2))
  end

  defp plural_to_singular_key(atom) do
    atom
    |> Atom.to_string()
    |> String.replace_leading("are_", "is_")
    |> String.replace_trailing("s", "")
    |> String.replace_trailing("ie", "y")
    |> String.to_atom()
  end

  defp checklist(atom, arg), do: checklist(atom, arg, [])

  defp checklist(_atom, [], acc), do: acc
  defp checklist(atom, [head | tail], acc) do
    checklist(atom, tail, [{atom, head} | acc])
  end
end
