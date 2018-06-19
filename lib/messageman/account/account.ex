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

	def get_account(account_sid) do
		Account.find(account_sid)
	end
	# Suspend a sub-account
	# Pass Account Struct as parameter
	def suspend_account(account) do
		Account.suspend(account)
	end

	def reactivate_account(account) do
		Account.reactivate(account)
	end

	def close_account(sid) do
		Account.close(sid)
	end
end
