defmodule Messageman.IncomingPhoneNumber do
	alias ExTwilio.IncomingPhoneNumber, as: ExIncomingPhoneNumber

	def list_phone_numbers() do
		ExIncomingPhoneNumber.all()
	end

	def buy_phone_number(area_code, account, token) do
		data = [AreaCode: area_code]
		options = [account: account, token: token]
		with {:ok, phone_number} <- ExIncomingPhoneNumber.create(data, options) do
			phone_number
		else
			{ :error, reason, http_status_code } -> { :error, reason, http_status_code }
		end

	end

	def release_phone_number(phone_sid, account, token) do
		options = [account: account, token: token]


		case ExIncomingPhoneNumber.destroy(phone_sid, options) do
			:ok -> {:ok, "Phone number is deleted from your account."}
			{:error, reason, http_status_code} -> { :error, reason, http_status_code }
		end
	end

	# def release_phone_number(phone_sid, account, token) do
	# 	options = [account: account, token: token]
	# 	IncomingPhoneNumber.destroy(phone_sid, options)
	# end
end
