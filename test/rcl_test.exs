defmodule RclTest do
  use ExUnit.Case
  doctest Rcl

  test "greets the world" do
    assert Rcl.hello() == :world
  end
end
