defmodule BcdTest do
  use ExUnit.Case
  doctest Bcd

  test "gets low nibble" do
    assert Bcd.low_nibble(82) == 2
  end

  test "get high nibble" do
    assert Bcd.high_nibble(82) == 5
  end

  test "converts from binary coded decimal" do
    assert Bcd.from_bcd(82) == 52
  end

  test "convert single nibble to decimal" do
    assert Bcd.from_bcd(0b0011) == 3
    assert Bcd.from_bcd(0b0101) == 5
  end

  test "converts to binary coded decimal" do
    assert Bcd.to_bcd(52) == 82
    assert Bcd.to_bcd(15) == 21
  end
end
