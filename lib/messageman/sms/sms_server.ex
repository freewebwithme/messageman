defmodule Messageman.Sms.SmsServer do
  use GenServer
  alias Messageman.Sms

  # Client
  def start_link(_) do
    IO.puts("Starting SMS Server..")
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def send_sms(phone_numbers, body, from_number) do
    GenServer.cast(__MODULE__, {:send_sms, phone_numbers, body, from_number})
  end

  def send_sms_with_messaging_service(phone_numbers, body, messaging_sid) do
    GenServer.cast(__MODULE__, {:send_sms_with_messaging_service, phone_numbers, body, messaging_sid})
  end

  #Server
  def init(args) do
    {:ok, args}
  end

  def handle_cast({:send_sms, phone_numbers, body, from_number}, state) do
    Sms.send_sms(phone_numbers, body, from_number)
    {:noreply, state}
  end

  def handle_cast({:send_sms_with_messaging_service, phone_numbers, body, messaging_sid}, state) do
    Sms.send_sms_with_messaging_service(phone_numbers, body, messaging_sid)
    {:noreply, state}
  end
end
