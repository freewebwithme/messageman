defmodule Messageman.Verify do
	alias ExTwilio.Verify
	alias Messageman.Config

	def verify_start(phone_number) do
		api_key = Config.verify_api_key()

		data = [via: "sms", phone_number: phone_number, country_code: 1, locale: "en"]
		with {:ok, %{message: message}} <- Verify.start(api_key, data) do
			{:ok, message}
		else
			{ :error, reason, http_status_code } -> { :error, reason, http_status_code }
		end
	end

	def verify_check(phone_number, code) do
		api_key = Config.verify_api_key()

		data = [phone_number: phone_number, country_code: 1, verification_code: code]
		with {:ok, %{message: message}} <- Verify.check(api_key, data) do
			{:ok, message}
		else
			{ :error, reason, http_status_code } -> { :error, reason, http_status_code }
		end
	end
end
