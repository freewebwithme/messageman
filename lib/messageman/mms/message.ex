defmodule Messageman.Mms.Message do
  alias ExTwilio.Message

  @moduledoc """
  Wrapper for ExTwilio.Message and GenServer
  """

  def create_mms_message(phone_numbers, body, from_number, media_url, account, token) do
    Message.create([to: phone_numbers, body: body, from: from_number, media_url: media_url], [account: account, token: token])
  end

  def create_mms_message_with_messaging_service(phone_numbers, msid, body, media_url, account, token) do
    Message.create([to: phone_numbers, messaging_service_sid: msid, body: body, media_url: media_url], [account: account, token: token])
  end
end
