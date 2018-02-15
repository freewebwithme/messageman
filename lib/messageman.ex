defmodule Messageman do

  alias Messageman.{Account, Sms, MessagingService, PhoneNumber, Verify}

  defdelegate send_sms(to_number, body, from_number, sid, token), to: Sms
  defdelegate create_account(friendly_name), to: Account

  defdelegate buy_phone_number(area_code, account, token), to: PhoneNumber

  defdelegate create_messaging_service(info), to: MessagingService
  defdelegate add_phone_number_to_messaging_service(phone_sid, messaging_sid, account, token), to: MessagingService

  defdelegate verify_start(phone_number), to: Verify
  defdelegate verify_check(phone_number, code), to: Verify
end
