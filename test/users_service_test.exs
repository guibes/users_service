defmodule UsersServiceTest do
  use ExUnit.Case
  doctest UsersService

  test "greets the world" do
    assert UsersService.hello() == :world
  end
end
