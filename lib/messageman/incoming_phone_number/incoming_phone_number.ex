defmodule Messageman.IncomingPhoneNumber do
	alias ExTwilio.IncomingPhoneNumber

	def list_phone_numbers() do
		IncomingPhoneNumber.all()
	end

	def buy_phone_number(area_code, account, token) do
		data = [AreaCode: area_code]
		options = [account: account, token: token]
		with {:ok, phone_number} <- IncomingPhoneNumber.create(data, options) do
			phone_number
		else
			{ :error, reason, http_status_code } -> { :error, reason, http_status_code }
		end

	end

	def release_phone_number(phone_sid, account, token) do
		options = [account: account, token: token]
		with :ok <- IncomingPhoneNumber.destroy(phone_sid, options) do
			{:ok, "Phone number is deleted from your account."}
		else
			{ :error, reason, http_status_code } -> { :error, reason, http_status_code }
		end
	end
end
