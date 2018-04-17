defmodule Messageman.Config do

	def verify_api_key, do: from_env(:ex_twilio, :verify_api_key)

	def from_env(otp_app, key, default \\ nil)
	def from_env(otp_app, key, default) do
		otp_app
		|> Application.get_env(key,default)
		|> read_from_system(default)
	end

	def get_credential_info() do
		account_sid = from_env(:ex_twilio, :account_sid)
		auth_token = from_env(:ex_twilio, :auth_token)
		{account_sid, auth_token}
	end

	defp read_from_system({:system, env}, default), do: System.get_env(env) || default
	defp read_from_system(value, _default), do: value

end
