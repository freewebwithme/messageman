defmodule Messageman.Sms.Message do
  alias ExTwilio.Message
  @moduledoc """
  Wrapper for ExTwilio.Message and GenServer
  """
  def create_message(phone_numbers, body, from_number, account, token) do
    Message.create([to: phone_numbers, body: body, from: from_number], [account: account, token: token])
  end

  def create_message_with_messaging_service(phone_numbers, messaging_service_sid, body, account, token) do
    Message.create([to: phone_numbers, messaging_service_sid: messaging_service_sid, body: body], [account: account, token: token])
  end
end
