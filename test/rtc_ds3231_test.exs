defmodule RtcDs3231Test do
  use ExUnit.Case
  doctest Decoder

  test "decode naive datetime" do
    test_date = ~N[2017-12-12 01:53:23]
    input = << 0b100011, 0b1010011, 0b1, 0b11, 0b10010, 0b10010, 0b10111 >>

    {:ok, date} = RtcDs3231.decode_datetime(input, 2000)

    diff = NaiveDateTime.compare(date, test_date)
    assert diff == :eq
  end

end
