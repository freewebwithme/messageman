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
		with {:ok, %{sid: phone_sid}} <- IncomingPhoneNumber.create(data, options) do
			phone_sid
		else
			{ :error, reason, http_status_code } -> { :error, reason, http_status_code }
		end

	end
end
