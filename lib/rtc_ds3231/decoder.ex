defmodule RtcDs3231.Decoder do
  @moduledoc false

  use Bitwise

  alias RtcDs3231.Bcd

  def decode_datetime(bytes, century) do
    << sec, min, hr, _dy, dt, mon, yr >> = bytes
    seconds = decode_seconds(sec)
    minutes = decode_minutes(min)
    hour = decode_hours(hr)
    day = decode_day(dt)
    month = decode_month(mon)
    year = decode_year(yr) + century

    NaiveDateTime.new(year, month, day, hour, minutes, seconds)
  end

  def decode_seconds(byte), do: Bcd.from_bcd(byte)
  def decode_minutes(byte), do: Bcd.from_bcd(byte)
  def decode_day(byte), do: Bcd.from_bcd(byte)
  def decode_year(byte), do: Bcd.from_bcd(byte)

  def decode_month(byte) do
    (byte &&& 0x1F)
    |> Bcd.from_bcd
  end

  def decode_hours(byte) do
    if military_time?(byte) do
      military_time(byte)
    else
      civil_time(byte)
    end
  end

  def civil_time(byte) do
    hour = (byte &&& 0x1F)
           |> Bcd.from_bcd
    hour + pm(byte)
  end

  def military_time(byte) do
    hours_byte =  byte &&& 0x3F
    Bcd.from_bcd(hours_byte)
  end


  def military_time?(byte) do
    (byte &&& (1 <<< 6)) == 0
  end

  def am?(byte) do
    (byte &&& (1 <<< 5)) == 0
  end

  def pm(byte) do
    if am?(byte) do
      0
    else
      12
    end
  end
end
