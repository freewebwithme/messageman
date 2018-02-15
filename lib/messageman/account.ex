defmodule Messageman.Account do
	alias ExTwilio.Account

	def all_account() do
		Account.all
	end

	# Create a sub-account in twilio and return account sid
	def create_account(friendly_name) do
		{ :ok, %{ sid: sid, auth_token: token, friendly_name: friendly_name } } = Account.create(["friendly_name": friendly_name])
		{ sid, token, friendly_name }
	end
end