defmodule RtcDs3231 do
  @moduledoc """
  Use a DS3231 real time clock with a nerves system

  Decode the first 7 bytes returned from the DS3231 as a date.
  https://datasheets.maximintegrated.com/en/ds/DS3231.pdf
  """

  alias ElixirALE.I2C
  alias RtcDs3231.Encoder
  alias RtcDs3231.Decoder

  @doc """
  Read the real time clock and return the time as a NaiveDateTime
  """
  def rtc_datetime(address, century \\ 2000) do
    {:ok, pid} = I2C.start_link("i2c-1", address)
    bytes = I2C.write_read(pid, <<0 >> , 7)
    Decoder.decode_datetime(bytes, century)
  end

  @doc """
  Set the real time clock, NOT IMPLEMENTED
  """
  def set_rtc_datetime(address, time) do
    {:ok, pid} = I2C.start_link("i2c-1", address)
    {:ok, bytes} = Encoder.encode_datetime(time)

    I2C.write(pid, << 0 >> <> bytes)
  end
end
