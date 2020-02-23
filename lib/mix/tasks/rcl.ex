defmodule Mix.Tasks.Rcl do
  use Mix.Task

  @shortdoc "Creates a new riak core light project"
  def run(args) do
    Rcl.run(args)
  end
end
