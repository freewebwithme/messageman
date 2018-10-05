defmodule Messageman.Helpers do

  def csv_reader(filename) do
    filename
    |> File.stream!()
    |> CSV.decode!()
    |> Enum.to_list()
  end

  @doc """
  contact_list is like [ ["Name", "2130009999"], [..]]
  extract only phone number and return phonenumber list
  ["2223334444", "1115556666", ...]
  """
  def extract_phonenumber(contact_list) do
    for [_name, phone_number] <- contact_list do
      phone_number
    end
  end
end
