defmodule Messageman.MessagingService do
	alias ExTwilio.Services.{ Service, AlphaSenderId }
	alias Messageman.Config

	defstruct [ :account_sid,
							:sid,
							:date_created,
							:date_updated,
							:friendly_name,
							:inbound_request_url,
							:inbound_method,
							:fallback_url,
							:fallback_method,
							:status_callback,
							:sticky_sender,
							:mms_converter,
							:links,
							:url
						]
	@doc """
	Create a messaging service in  twilio
	Provide a friendly name.
	"""

	#TODO: Add status callback
	def create_messaging_service(account, token, friendly_name) do
		# name = [FriendlyName: friendly_name, StatusCallback: status_callback]
		name = [FriendlyName: friendly_name]
		options = [account: account, token: token]

		with { :ok, %{sid: messaging_service_sid} } <- Service.create(name, options) do
			messaging_service_sid
		else
			{ :error, reason, http_status_code } -> { :error, reason, http_status_code }
		end
	end



	@doc """
	Add Alpha Sender Id to Messaging Service
	"""
	def add_alpha_sender_id_to_service(messaging_sid, name) do
		{account, token} = Config.get_credential_info()
		with {:ok, %{ sid: alpha_sender_sid, alpha_sender: sender_name }} <- AlphaSenderId.add_alpha_sender_id(messaging_sid, [alpha_sender: name], [account: account, token: token]) do
			{:ok, sender_name, alpha_sender_sid}
		else
			{ :error, reason, http_status_code } -> { :error, reason, http_status_code }
		end
	end

	# Update alpha sender ID or Delete
	@doc """
	Get Alpha Sender ID From Messaging Service
	"""
	def get_alpha_sender_id(messaging_sid) do
		{account, token} = Config.get_credential_info()
		with {:ok, result} <- AlphaSenderId.get_alpha_sender_id(messaging_sid, [account: account, token: token]) do
			{ result }
		else
			{ :error, reason, http_status_code } -> { :error, reason, http_status_code }
		end
	end
end
