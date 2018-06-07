defmodule Messageman.Mms do
  alias ExTwilio.Message
  alias Messageman.Config


  @doc """
  Send MMS using 1 phone number
  """
  @spec send_mms(list, String.t, String.t, String.t) :: map
  def send_mms(phone_numbers, body, from_number, media_url) do
    {account, token} = Config.get_credential_info()
    phone_numbers
    |> Enum.map(&Message.create([to: &1, body: body, from: from_number, media_url: media_url], [account: account, token: token]))
    |> Enum.group_by(&elem(&1, 0))
  end

  @doc """
  Send MMS using Messaging Service
  """
  @spec send_mms_with_messaging_service(list, String.t, String.t, String.t) :: map
  def send_mms_with_messaging_service(phone_numbers, body, messaging_sid, media_url) do
    {account, token} = Config.get_credential_info()
    phone_numbers
    |> Enum.map(&Message.create([to: &1, messaging_service_sid: messaging_sid, body: body, media_url: media_url], [account: account, token: token]))
    |> Enum.group_by(&elem(&1, 0))
  end
end
