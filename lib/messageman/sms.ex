defmodule Messageman.Sms do
	alias ExTwilio.Message

	def send_sms(to_number, body, from_number, sid, token) do
		Message.create([to: to_number, body: body, from: from_number], [account: sid, token: token])
	end
end