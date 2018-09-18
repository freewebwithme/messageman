defmodule Messageman.Lookup do
  alias ExTwilio.Lookup, as: ExTwilioLookup

  def retrieve_phonenumber_info(phone_number) do
    {:ok, phonenumber_info} = ExTwilioLookup.retrieve(phone_number, [Type: "carrier"])
    phonenumber_info
  end

  def is_mobile_number?(phone_number) do
    {:ok, %{carrier: %{"type" => carrier_type}}} = ExTwilioLookup.retrieve(phone_number, [Type: "carrier"])
    if carrier_type == "landline" do
      false
    else
      true
    end
  end

  def is_landline_number?(phone_number) do
    {:ok, %{carrier: %{"type" => carrier_type}}} = ExTwilioLookup.retrieve(phone_number, [Type: "carrier"])
    if carrier_type == "landline" do
      true
    else
      false
    end
  end
end
