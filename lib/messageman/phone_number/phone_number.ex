defmodule Messageman.PhoneNumber do
	alias ExTwilio.IncomingPhoneNumber
	alias Messageman.Config

	def list_phone_numbers() do
		IncomingPhoneNumber.all()
	end

	def buy_phone_number(area_code) do
		{account, token} = Config.get_credential_info()
		data = [AreaCode: area_code]
		options = [account: account, token: token]
		with {:ok, phone_number} <- IncomingPhoneNumber.create(data, options) do
			phone_number
		else
			{ :error, reason, http_status_code } -> { :error, reason, http_status_code }
		end

	end
end
