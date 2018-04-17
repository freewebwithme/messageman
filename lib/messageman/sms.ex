defmodule Messageman.Sms do
	alias ExTwilio.Message
	alias Messageman.Config


	def send_sms([head_number | tail_number], body, from_number) do
		{account, token} = Config.get_credential_info()
		with { :ok, %{body: message, from: from, to: to} }
		 <- Message.create([to: head_number, body: body, from: from_number], [account: account, token: token]) do
			{ message, from, to }
		else
			{:error, reason, http_status_code} -> {:error, reason, http_status_code}
		end
		send_sms(tail_number, body, from_number)
	end

	def send_sms([], _body, _from_number), do: :done



	@doc """
	Send messages using Messaging Service
	"""


	def send_sms_with_messageing_service([head_number | tail_number], body, mss) do
		{account, token} = Config.get_credential_info()
		with { :ok, %{to: to, body: sent_message} } <- Message.create([to: head_number, messaging_service_sid: mss, body: body], [account: account, token: token]) do
			{ to, sent_message}
		else
			{:error, reason, http_status_code} -> {:error, reason, http_status_code}
		end
		send_sms_with_messageing_service(tail_number, body, mss)
	end

	def send_sms_with_messageing_service([], _body, _mss), do: :done

end
