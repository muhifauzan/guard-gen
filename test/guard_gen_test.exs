defmodule GuardGenTest do
  use ExUnit.Case

  doctest GuardGen

  defmodule Test do
    import GuardGen

    def test(arg) when is_valid(is_atom: arg) do
      inspect(arg)
    end
  end

  describe "is_valid/2" do
    test "returns true when type-check is_atom/1 on :atom" do
      assert true == GuardGen.is_valid(is_atom: :atom)
    end

    test "returns true when type-check is_atom/1 on var :atom" do
      var = :atom
      assert true == GuardGen.is_valid(is_atom: var)
    end

    test "returns true when type-check is_binary/1 on <<2>>" do
      assert true == GuardGen.is_valid(is_binary: <<2>>)
    end

    test "returns true when type-check is_binary/1 on var <<2>>" do
      var = <<2>>
      assert true == GuardGen.is_valid(is_binary: var)
    end

    test "returns true when type-check is_bitstring/1 on <<2::2>>" do
      assert true == GuardGen.is_valid(is_bitstring: <<2::2>>)
    end

    test "returns true when type-check is_bitstring/1 on var <<2::2>>" do
      var = <<2::2>>
      assert true == GuardGen.is_valid(is_bitstring: var)
    end

    test "returns true when type-check is_boolean/1 on true" do
      assert true == GuardGen.is_valid(is_boolean: true)
    end

    test "returns true when type-check is_boolean/1 on var true" do
      var = true
      assert true == GuardGen.is_valid(is_boolean: var)
    end

    test "returns true when type-check is_float/1 on 1.0" do
      assert true == GuardGen.is_valid(is_float: 1.0)
    end

    test "returns true when type-check is_float/1 on var 1.0" do
      var = 1.0
      assert true == GuardGen.is_valid(is_float: var)
    end

    test "returns true when type-check is_function/1 on fn/1" do
      assert true == GuardGen.is_valid(is_function: fn x -> x end)
    end

    test "returns true when type-check is_function/1 on var fn/1" do
      var = fn x -> x end
      assert true == GuardGen.is_valid(is_function: var)
    end

    test "returns true when type-check is_function/2 on [fn/1, 1]" do
      assert true == GuardGen.is_valid(is_function: [fn x -> x end, 1])
    end

    test "returns true when type-check is_function/2 on [var fn/1, 1]" do
      var = fn x -> x end
      assert true == GuardGen.is_valid(is_function: [var, 1])
    end

    test "returns true when type-check is_function/2 on [fn/1, var 1]" do
      var = 1
      assert true == GuardGen.is_valid(is_function: [fn x -> x end, var])
    end

    test "returns true when type-check is_function/2 on [var fn/1, var 1]" do
      var1 = fn x -> x end
      var2 = 1
      assert true == GuardGen.is_valid(is_function: [var1, var2])
    end

    test "returns false when type-check is_function/1 on var [fn/1, 1]" do
      var = [fn x -> x end, 1]
      assert false == GuardGen.is_valid(is_function: var)
    end

    test "returns false when type-check is_function/2 on [fn/1, 2]" do
      refute true == GuardGen.is_valid(is_function: [fn x -> x end, 2])
    end

    test "returns true when type-check is_integer/1 on 1" do
      assert true == GuardGen.is_valid(is_integer: 1)
    end

    test "returns true when type-check is_integer/1 on var 1" do
      var = 1
      assert true == GuardGen.is_valid(is_integer: var)
    end

    test "returns true when type-check is_list/1 on [1, 2, 3]" do
      assert true == GuardGen.is_valid(is_list: [1, 2, 3])
    end

    test "returns true when type-check is_list/1 on var [1, 2, 3]" do
      var = [1, 2, 3]
      assert true == GuardGen.is_valid(is_list: var)
    end

    test "returns true when type-check is_map/1 on %{a: :a, b: :b, c: :c}" do
      assert true == GuardGen.is_valid(is_map: %{a: :a, b: :b, c: :c})
    end

    test "returns true when type-check is_map/1 on var = %{a: :a, b: :b, c: :c}" do
      var = %{a: :a, b: :b, c: :c}
      assert true == GuardGen.is_valid(is_map: var)
    end

    test "returns true when type-check is_nil/1 on nil" do
      assert true == GuardGen.is_valid(is_nil: nil)
    end

    test "returns true when type-check is_nil/1 on var nil" do
      var = nil
      assert true == GuardGen.is_valid(is_nil: var)
    end

    test "returns true when type-check is_number/1 on 1" do
      assert true == GuardGen.is_valid(is_number: 1)
    end

    test "returns true when type-check is_number/1 on var 1" do
      var = 1
      assert true == GuardGen.is_valid(is_number: var)
    end

    test "returns true when type-check is_pid/1 on self/0" do
      assert true == GuardGen.is_valid(is_pid: self())
    end

    test "returns true when type-check is_pid/1 on var self/0" do
      var = self()
      assert true == GuardGen.is_valid(is_pid: var)
    end

    test "returns true when type-check is_port/1 on Port.open/2" do
      assert true ==
        GuardGen.is_valid(is_port: Port.open({:spawn, "cat"}, [:binary]))
    end

    test "returns true when type-check is_port/1 on var Port.open/2" do
      var = Port.open({:spawn, "cat"}, [:binary])
      assert true == GuardGen.is_valid(is_port: var)
    end

    test "returns true when type-check is_reference/1 on make_ref/0" do
      assert true == GuardGen.is_valid(is_reference: make_ref())
    end

    test "returns true when type-check is_reference/1 on var make_ref/0" do
      var = make_ref()
      assert true == GuardGen.is_valid(is_reference: var)
    end

    test "returns true when type-check is_tuple/1 on {:a, :b, :c}" do
      assert true == GuardGen.is_valid(is_tuple: {:a, :b, :c})
    end

    test "returns true when type-check is_tuple/1 on var = {:a, :b, :c}" do
      var = {:a, :b, :c}
      assert true == GuardGen.is_valid(is_tuple: var)
    end

    test "returns true when check in/2 on [1, [1, 2, 3]]" do
      assert true == GuardGen.is_valid(in: [1, [1, 2, 3]])
    end

    test "returns true when check in/2 on [var 1, [1, 2, 3]]" do
      var = 1
      assert true == GuardGen.is_valid(in: [var, [1, 2, 3]])
    end

    test "returns true when check in/2 on [var 1, var [1, 2, 3]]" do
      var = [1, 2, 3]
      assert true == GuardGen.is_valid(in: [1, var])
    end

    test "returns false when type-check in/2 on [1, [2, 3, 4]]" do
      refute true == GuardGen.is_valid(in: [1, [2, 3, 4]])
    end

    test "returns true when checks combination on all return true checks" do
      assert true == GuardGen.is_valid(is_atom: :atom, is_binary: <<2>>,
        is_bitstring: <<2::2>>, is_boolean: true, is_float: 1.0,
        is_function: fn x -> x end, is_function: [fn x -> x end, 1],
        is_integer: 1, is_list: [1, 2, 3], is_map: %{a: :a, b: :b, c: :c},
        is_nil: nil, is_number: 1, is_pid: self(),
        is_port: Port.open({:spawn, "cat"}, [:binary]), is_reference: make_ref(),
        is_tuple: {:a, :b, :c})
    end

    test "returns true when type-check are_atoms/1 on [:a, :b, :c]" do
      assert true == GuardGen.is_valid(are_atoms: [:a, :b, :c])
    end

    test "returns false when type-check are_atoms/1 on [1, :a, :b]" do
      refute true == GuardGen.is_valid(are_atoms: [1, :a, :b])
    end

    test "returns false when type-check are_atoms/1 on [:a, 1, :b]" do
      refute true == GuardGen.is_valid(are_atoms: [:a, 1, :b])
    end

    test "returns false when type-check are_atoms/1 on [:a, :b, 1]" do
      refute true == GuardGen.is_valid(are_atoms: [:a, :b, 1])
    end

    test "returns true when type-check are_lists/1 on [[], [1, 2, 3]]" do
      assert true == GuardGen.is_valid(are_lists: [[], [1, 2, 3]])
    end

    test "returns true when type-check are_functions/2 on [[fn/1, 1], fn/2, 2]" do
      assert true == GuardGen.is_valid(are_functions: [
            [fn x -> x end, 1], [fn x, y -> [x, y] end, 2]])
    end

    test "returns false when type-check are_functions/2 on [[fn/1, 2], [fn2/, 1]]" do
      refute true == GuardGen.is_valid(are_functions: [
            [fn x -> x end, 2], [fn x, y -> [x, y] end, 1]])
    end

    test "returns false when type-check are_nils/1 on [1, nil, nil]" do
      refute true == GuardGen.is_valid(are_nils: [1, nil, nil])
    end

    test "returns false when type-check are_tuples/1 on [1, {:a, :b, :c}]" do
      refute true == GuardGen.is_valid(are_tuples: [1, {:a, :b, :c}])
    end

    test "allowed in guard test" do
      assert ":atom" == Test.test(:atom)
    end

    test "raise FunctionClauseError on fail guard test" do
      assert_raise FunctionClauseError, fn ->
        Test.test(1)
      end
    end
  end
end

#  LocalWords:  FunctionClauseError
