defmodule Messageman.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Messageman.Server, nil}
    ]

    opts = [strategy: :one_for_one, name: Messageman.Supervisor ]
    Supervisor.start_link(children, opts)
  end
end
