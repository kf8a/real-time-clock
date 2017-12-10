defmodule RtcDs3231Test do
  use ExUnit.Case
  doctest RtcDs3231

  test "decode 24 hour value" do
    assert RtcDs3231.decode_hours(0b01010111) == 17
  end

  test "decode 12 hour flag" do
    assert RtcDs3231.military_time?(0b01110011) == false
  end

  test "decode 24 hour flag" do
    assert RtcDs3231.military_time?(0b00010111) == true
  end

  test "decode pm 12 hour value am" do
    assert RtcDs3231.decode_hours(0b01100011) == 15
  end

  test "decode a am 12 hour value am" do
    assert RtcDs3231.decode_hours(0b00000011) == 3
  end

  test "deocde month" do
    assert RtcDs3231.decode_month(0b10000111) == 7
  end
end
