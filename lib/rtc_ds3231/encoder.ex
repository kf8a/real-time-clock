defmodule RtcDs3231.Encoder do
  @moduledoc false

  alias RtcDs3231.Bcd

  def encode_datetime(datetime) do
    {:ok,
     <<encode(datetime.second), encode(datetime.minute), encode(datetime.hour),
       encode_day_of_week(datetime), encode(datetime.day), encode(datetime.month),
       encode_year(datetime)>>}
  end

  def encode_day_of_week(datetime) do
    dow = Date.day_of_week(datetime)

    (dow + 1)
    |> rem(7)
    |> encode
  end

  @doc """
  Throw away the century
  """
  def encode_year(datetime) do
    rem(datetime.year, 100)
    |> encode
  end

  def encode(value), do: Bcd.to_bcd(value)
end
