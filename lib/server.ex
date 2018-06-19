defmodule Messageman.Server do
  use GenServer
  alias Messageman.{Sms, Mms}

  # Client
  def start_link(_) do
    IO.puts("Starting Messageman Server..")
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def send_sms(phone_numbers, body, from_number, account, token) do
    GenServer.cast(__MODULE__, {:send_sms, phone_numbers, body, from_number, account, token})
  end

  def send_sms_with_messaging_service(phone_numbers, body, messaging_sid, account, token) do
    GenServer.cast(__MODULE__, {:send_sms_with_messaging_service, phone_numbers, body, messaging_sid, account, token})
  end

  def send_mms(phone_numbers, body, from_number, media_url, account, token) do
    GenServer.cast(__MODULE__, {:send_mms, phone_numbers, body, from_number, media_url, account, token})
  end

  def send_mms_with_messaging_service(phone_numbers, body, msid, media_url, account, token) do
    GenServer.cast(__MODULE__, {:send_mms_with_messaging_service, phone_numbers, body, msid, media_url, account, token})
  end


  #Server
  def init(args) do
    {:ok, args}
  end

  def handle_cast({:send_sms, phone_numbers, body, from_number, account, token}, state) do
    Sms.send_sms(phone_numbers, body, from_number, account, token)
    {:noreply, state}
  end

  def handle_cast({:send_sms_with_messaging_service, phone_numbers, body, messaging_sid, account, token}, state) do
    Sms.send_sms_with_messaging_service(phone_numbers, body, messaging_sid, account, token)
    {:noreply, state}
  end

  def handle_cast({:send_mms, phone_numbers, body, from_number, media_url, account, token}, state) do
    Mms.send_mms(phone_numbers, body, from_number, media_url, account, token)
    {:noreply, state}
  end

  def handle_cast({:send_mms_with_messaging_service, phone_numbers, body, msid, media_url, account, token}, state) do
    Mms.send_mms_with_messaging_service(phone_numbers, body, msid, media_url, account, token)
    {:noreply, state}
  end
end
