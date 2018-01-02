defmodule DecoderTest do
  use ExUnit.Case

  test "decode 24 hour value" do
    assert Decoder.decode_hours(0b01010111) == 17
  end

  test "decode 12 hour flag" do
    assert Decoder.military_time?(0b01110011) == false
  end

  test "decode 24 hour flag" do
    assert Decoder.military_time?(0b00010111) == true
  end

  test "decode pm 12 hour value am" do
    assert Decoder.decode_hours(0b01100011) == 15
  end

  test "decode a am 12 hour value am" do
    assert Decoder.decode_hours(0b00000011) == 3
  end

  test "deocde month" do
    assert Decoder.decode_month(0b10000111) == 7
  end

  test "decode naive datetime" do
   test_date = ~N[2017-12-12 01:53:23]
    input = << 0b100011, 0b1010011, 0b1, 0b11, 0b10010, 0b10010, 0b10111 >>

    {:ok, date} = Decoder.decode_datetime(input, 2000)

    diff = NaiveDateTime.compare(date, test_date)
    assert diff == :eq
  end
end
