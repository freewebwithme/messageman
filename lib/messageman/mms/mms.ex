defmodule Messageman.Mms do
  alias Messageman.Mms.Message



  @doc """
  Send MMS using 1 phone number
  """
  @spec send_mms(list, String.t, String.t, String.t, String.t, String.t) :: map
  def send_mms(phone_numbers, body, from_number, media_url, account, token) do
    phone_numbers
    |> Enum.map(&Message.create_mms_message(&1, body, from_number, media_url, account, token))
    |> Enum.group_by(&elem(&1, 0))
  end

  @doc """
  Send MMS using Messaging Service
  """
  @spec send_mms_with_messaging_service(list, String.t, String.t, String.t, String.t, String.t) :: map
  def send_mms_with_messaging_service(phone_numbers, body, messaging_sid, media_url, account, token) do
    phone_numbers
    |> Enum.map(&Message.create_mms_message_with_messaging_service(&1, messaging_sid, body, media_url, account, token))
    |> Enum.group_by(&elem(&1, 0))
  end
end
