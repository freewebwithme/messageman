defmodule MessagemanTest do
  use ExUnit.Case
  doctest Messageman
  alias Messageman

  test "greets the world" do
    assert Messageman.hello() == :world
  end

end
