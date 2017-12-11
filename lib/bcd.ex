defmodule Bcd do
  @moduledoc false
  use Bitwise

  @doc """
  Convert from bcd to integers
  """
  def from_bcd(byte), do: high_nibble(byte) * 10 + low_nibble(byte)

  @doc """
  Convert number to binary coded decimal
  """
  def to_bcd(number) do
    high = div(number, 10)
    low = rem(number, 10)
    (high <<< 4) ||| low
  end

  def low_nibble(byte),  do: byte &&& 0xF

  def high_nibble(byte),  do: byte >>> 4
end
