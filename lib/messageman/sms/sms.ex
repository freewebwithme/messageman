defmodule Messageman.Sms do
  alias Messageman.Sms.Message

  @doc """
  Send SMS using 1 phone number
  """
  def send_sms(phone_numbers, body, from_number, status_callback, account, token) do
    phone_numbers
    |> Enum.map(&Message.create_message(&1, body, from_number, status_callback, account, token))

    # |> Enum.group_by(&elem(&1, 0))
  end

  def send_sms_async(phone_numbers, body, from_number, status_callback, account, token) do
    Task.Supervisor.async_stream(
      Messageman.TaskSupervisor,
      phone_numbers,
      Messageman.Sms.Message,
      :create_message,
      [body, from_number, status_callback, account, token],
      max_concurrency: 20
    )
    |> Enum.to_list()
    |> extracting_message()
  end

  @doc """
  Send SMS using Messaging Service
  """
  @spec send_sms_with_messaging_service(
          list,
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          String.t()
        ) :: map
  def send_sms_with_messaging_service(
        phone_numbers,
        body,
        messaging_service_sid,
        status_callback,
        account,
        token
      ) do
    phone_numbers
    |> Enum.map(
      &Message.create_message_with_messaging_service(
        &1,
        messaging_service_sid,
        body,
        status_callback,
        account,
        token
      )
    )
    |> Enum.group_by(&elem(&1, 0))
  end

  def send_sms_with_messaging_service_async(
        phone_numbers,
        body,
        messaging_service_sid,
        status_callback,
        account,
        token
      ) do
    max_concurrency = System.schedulers_online() * 2

    Task.Supervisor.async_stream(
      Messageman.TaskSupervisor,
      phone_numbers,
      Messageman.Sms.Message,
      :create_message_with_messaging_service,
      [messaging_service_sid, body, status_callback, account, token],
      max_concurrency: max_concurrency
    )
    |> Enum.to_list()
    |> extracting_message()
  end

  def extracting_message(results) do
    for {:ok,
         {:ok, %{account_sid: account_sid, body: body, sid: message_sid, status: status, to: to}}} <-
          results do
      %{account_sid: account_sid, body: body, message_sid: message_sid, status: status, to: to}
    end
  end
end
