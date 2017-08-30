defmodule CodeChange.Worker do
  use GenServer
  require Logger

  @vsn 3

  def struct_version do
    @vsn
  end

  defmodule State do
    defstruct current_value: nil
  end

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def get do
    GenServer.call(__MODULE__, :get)
  end

  def set(value) do
    GenServer.cast(__MODULE__, {:set, value})
  end

  def init(current_value) do
    {:ok, %State{current_value: current_value}}
  end

  def handle_call(:get, _from, state) do
    {:reply, state.current_value, state}
  end

  def handle_cast({:set, value}, state) do
    {:noreply, %{state | current_value: value}}
  end

  def code_change(old_vsn, state, _extra) do
    Logger.info """

      old_vsn #{inspect(old_vsn)}
    """
    {:ok, state}
  end
end
