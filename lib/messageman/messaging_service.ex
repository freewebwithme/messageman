defmodule Messageman.MessagingService do
	alias ExTwilio.Services.{ Service, PhoneNumbers }

	@doc """
	Create a messaging service in  twilio
	Provide account sid and auth token with friendly name.
	"""
	# def create_messaging_service(%{ account_sid: account, account_token: token, friendly_name: friendly_name }) do
	# 	name = [FriendlyName: friendly_name]
	# 	options = [account: account, token: token]
	# 	{ :ok, %{ sid: messaging_service_sid } } = Service.create(name, options)
	# 	messaging_service_sid
	# end

	#TODO: Add status callback
	def create_messaging_service({account, token, friendly_name}) do
		# name = [FriendlyName: friendly_name, StatusCallback: status_callback]
		name = [FriendlyName: friendly_name]
		options = [account: account, token: token]
		{ :ok, %{ sid: messaging_service_sid } } = Service.create(name, options)
		messaging_service_sid
	end

	# Add phone number to messaging service

	def add_phone_number_to_messaging_service(phone_sid, messaging_sid, account, token) do
		phone_number_sid = [PhoneNumberSid: phone_sid]
		options = [account: account, token: token]
		{ :ok, %{ phone_number: phone_number } } = PhoneNumbers.add(phone_number_sid, messaging_sid, options)
		phone_number
	end
end