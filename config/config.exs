# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
#     config :guard_gen, key: :value
#
# And access this configuration in your application as:
#
#     Application.get_env(:guard_gen, :key)
#
# Or configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"

config :guard_gen,
  original_keys: [
    :is_atom, :is_binary, :is_bitstring, :is_boolean, :is_float, :is_function,
    :is_integer, :is_list, :is_map, :is_nil, :is_number, :is_pid, :is_port,
    :is_reference, :is_tuple, :in
  ],
  modified_keys: [
    :are_atoms, :are_binaries, :are_bitstrings, :are_booleans, :are_floats,
    :are_functions, :are_integers, :are_lists, :are_maps, :are_nils,
    :are_numbers, :are_pids, :are_ports, :are_references, :are_tuples, :ins
  ]
