defmodule Messageman.Config do
	
	def verify_api_key, do: from_env(:ex_twilio, :verify_api_key)
	
	def from_env(otp_app, key, default \\ nil)
	def from_env(otp_app, key, default) do
		otp_app
		|> Application.get_env(key,default)
		|> read_from_system(default)
	end

	defp read_from_system({:system, env}, default), do: System.get_env(env) || default
  defp read_from_system(value, _default), do: value
end