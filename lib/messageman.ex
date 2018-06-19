defmodule Messageman do

  alias Messageman.{Account, MessagingService, IncomingPhoneNumber, Verify}
  alias Messageman.MessagingSerivce.PhoneNumber, as: MessagingServicePhoneNumber
  alias Messageman.Server

  defdelegate send_sms(to_number, body, from_number, account, token), to: Server
  defdelegate send_sms_with_messaging_service(phone_numbers, body, messaging_sid, account, token), to: Server

  defdelegate send_mms(phone_numbers, body, from_number, media_url, account, token), to: Server
  defdelegate send_mms_with_messaging_service(phone_numbers, body, msid, media_url, account, token), to: Server

  # Account
  defdelegate create_account(friendly_name), to: Account
  defdelegate get_account(account_sid), to: Account
  defdelegate suspend_account(accunt), to: Account
  defdelegate reactivate_account(account), to: Account
  defdelegate close_account(sid), to: Account

  # Incoming phone number
  defdelegate buy_phone_number(area_code, account, token), to: IncomingPhoneNumber
  defdelegate release_phone_number(phone_sid, account, token), to: IncomingPhoneNumber

  defdelegate create_messaging_service(account, token, friendly_name), to: MessagingService
  defdelegate add_phone_number_to_messaging_service(phone_sid, messaging_sid, account, token), to: MessagingServicePhoneNumber
  defdelegate list_phone_numbers_in_messagin_service(messaging_sid, account, token), to: MessagingServicePhoneNumber
  defdelegate get_phone_number_in_messaging_service(messaging_sid, phone_sid, account, token), to: MessagingServicePhoneNumber

  defdelegate verify_start(phone_number), to: Verify
  defdelegate verify_check(phone_number, code), to: Verify
end
