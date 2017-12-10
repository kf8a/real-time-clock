defmodule RtcDs3231 do

  use Bitwise

  def decode_seconds(byte), do: Bcd.from_bcd(byte)
  def decode_minutes(byte), do: Bcd.from_bcd(byte)
  def decode_date(byte), do: Bcd.from_bcd(byte)
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
