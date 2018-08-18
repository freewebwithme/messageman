defmodule Messageman.Mms do
  alias Messageman.Mms.Message

  @doc """
  Send MMS using 1 phone number
  """
  @spec send_mms(list, String.t, String.t, String.t, String.t, String.t, String.t) :: map
  def send_mms(phone_numbers, body, from_number, media_url, status_callback, account, token) do
    phone_numbers
    |> Enum.map(&Message.create_mms_message(&1, body, from_number, media_url, status_callback, account, token))
    |> Enum.group_by(&elem(&1, 0))
  end

  @doc """
  Send MMS using Messaging Service
  """
  @spec send_mms_with_messaging_service(list, String.t, String.t, String.t, String.t, String.t, String.t) :: map
  def send_mms_with_messaging_service(phone_numbers, body, messaging_sid, media_url, status_callback, account, token) do
    phone_numbers
    |> Enum.map(&Message.create_mms_message_with_messaging_service(&1, messaging_sid, body, media_url, status_callback, account, token))
    |> Enum.group_by(&elem(&1, 0))
  end

  def send_mms_with_messaging_service_async(phone_numbers, body, messaging_sid, media_url, status_callback, account, token) do
    Task.Supervisor.async_stream(Messageman.TaskSupervisor, phone_numbers, Messageman.Mms.Message,
      :create_mms_message_with_messaging_service,
      [messaging_sid, body, media_url, status_callback, account, token],
      [max_concurrency: 20])
    |> Enum.to_list
    |> Enum.map(fn {:ok, {:ok, %{account_sid: account_sid, body: body, sid: message_sid, status: status, to: to}}} ->
			%{account_sid: account_sid, body: body, message_sid: message_sid, status: status, to: to}
		end)
  end
end
