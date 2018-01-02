defmodule RtcDs3231.EncoderTest do
  use ExUnit.Case

  alias RtcDs3231.Encoder

  test "encode native datetime" do
    test_date = ~N[2017-12-12 01:53:23]
    test_bytes = << 0b100011, 0b1010011, 0b1, 0b11, 0b10010, 0b10010, 0b10111 >>

    {:ok, bytes} = Encoder.encode_datetime(test_date)

    assert test_bytes == bytes
  end

  test "encode day of week" do
    test_date = ~N[2017-12-12 01:53:23]
    assert 3 == Encoder.encode_day_of_week(test_date)
  end
end
