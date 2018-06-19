defmodule Messageman.Sms do
	alias Messageman.Sms.Message

	@doc """
	Send SMS using 1 phone number
	"""
	@spec send_sms(list, String.t, String.t, String.t, String.t) :: map
	def send_sms(phone_numbers, body, from_number, account, token) do
		phone_numbers
		|> Enum.map(&Message.create_message(&1, body, from_number, account, token))
		|> Enum.group_by(&elem(&1, 0))
	end

	@doc """
	Send SMS using Messaging Service
	"""
	@spec send_sms_with_messaging_service(list, String.t, String.t, String.t, String.t) :: map
	def send_sms_with_messaging_service(phone_numbers, body, messaging_service_sid, account, token) do
		phone_numbers
		|> Enum.map(&Message.create_message_with_messaging_service(&1, messaging_service_sid, body, account, token))
		|> Enum.group_by(&elem(&1, 0))
	end
end
