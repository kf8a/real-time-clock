defmodule RtcDs3231 do
  @moduledoc """
  Use a DS3231 real time clock with a nerves system
  """

  alias ElixirALE.I2C

  @doc """
  Read the real time clock and return the time as a NaiveDateTime
  """
  def rtc_datetime(address, century \\ 2000) do
    {:ok, pid} = I2C.start_link("i2c-1", address)
    bytes = I2C.write_read(pid, <<0 >> , 7)
    decode_datetime(bytes, century)
  end

  @doc """
  Set the real time clock, NOT IMPLEMENTED
  """
  def set_rtc_datetime(_address, _time) do
  end

  @doc """
  Decode the first 7 bytes returned from the DS3231 as a date.
  https://datasheets.maximintegrated.com/en/ds/DS3231.pdf
  """
  def decode_datetime(bytes, century) do
    << sec, min, hr, _dy, dt, mon, yr >> = bytes
    seconds = Decoder.decode_seconds(sec)
    minutes = Decoder.decode_minutes(min)
    hour = Decoder.decode_hours(hr)
    day = Decoder.decode_day(dt)
    month = Decoder.decode_month(mon)
    year = Decoder.decode_year(yr) + century

    NaiveDateTime.new(year, month, day, hour, minutes, seconds)
  end

end
