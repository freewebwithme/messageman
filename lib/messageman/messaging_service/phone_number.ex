defmodule Messageman.MessagingSerivce.PhoneNumber do
  alias ExTwilio.Services.PhoneNumbers

  @doc """
	 Add phone number to messaging service
	"""
	def add_phone_number_to_messaging_service(phone_sid, messaging_sid, account, token) do
		phone_number_sid = [PhoneNumberSid: phone_sid]
		options = [account: account, token: token]
		with { :ok, %{ phone_number: phone_number } } <- PhoneNumbers.add(phone_number_sid, messaging_sid, options) do
			phone_number
		else
			{ :error, reason, http_status_code } -> { :error, reason, http_status_code }
		end
	end

	@doc """
	List phone numbers in a service
	"""
  def list_phone_numbers_in_messagin_service(messaging_sid, account, token) do
    PhoneNumbers.list_phone_number_in_messaging_service(messaging_sid, [account: account, token: token])
  end

  def get_phone_number_in_messaging_service(messaging_sid, phone_sid, account, token) do
    PhoneNumbers.get_phone_number_in_messaging_service([PhoneNumberSid: phone_sid], messaging_sid, [account: account, token: token])
  end
end
