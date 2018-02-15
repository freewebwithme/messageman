defmodule Messageman.PhoneNumber do
	alias ExTwilio.IncomingPhoneNumber

	def list_phone_numbers() do
		IncomingPhoneNumber.all()
	end

	def buy_phone_number(area_code, account, token) do
		data = [AreaCode: area_code]
		options = [account: account, token: token]
		{:ok, %{sid: phone_sid}} = IncomingPhoneNumber.create(data, options)
		phone_sid
	end
end