defmodule Messageman.MessagingService do
	alias ExTwilio.Services.{ Service, PhoneNumbers }
	alias Messageman.Config

	@doc """
	Create a messaging service in  twilio
	Provide a friendly name.
	"""

	#TODO: Add status callback
	def create_messaging_service(friendly_name) do
		# name = [FriendlyName: friendly_name, StatusCallback: status_callback]
		{account, token} = Config.get_credential_info()

		name = [FriendlyName: friendly_name]
		options = [account: account, token: token]

		with { :ok, [%{ sid: messaging_service_sid}] } <- Service.create(name, options) do
			messaging_service_sid
		else
			{ :error, reason, http_status_code } -> { :error, reason, http_status_code }
		end
	end

	@doc """
	 Add phone number to messaging service
	"""

	def add_phone_number_to_messaging_service(phone_sid, messaging_sid) do
		{account, token} = Config.get_credential_info()
		phone_number_sid = [PhoneNumberSid: phone_sid]
		options = [account: account, token: token]
		with { :ok, [%{ phone_number: phone_number }] } <- PhoneNumbers.add(phone_number_sid, messaging_sid, options) do
			phone_number
		else
			{ :error, reason, http_status_code } -> { :error, reason, http_status_code }
		end
	end
end
