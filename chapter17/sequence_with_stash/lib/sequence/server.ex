defmodule Sequence.Server do
  use GenServer

  def start_link(pid_stash) do
    GenServer.start_link(__MODULE__, pid_stash, name: __MODULE__)
  end

  def next_number do
    GenServer.call(__MODULE__, :next_number)
  end

  def increment_number(delta) do
    GenServer.cast(__MODULE__, {:increment_number, delta})
  end

  #####
  # callback functions

  def init(pid_stash) do
    current_number = Sequence.Stash.get_value(pid_stash)
    {:ok, {current_number, pid_stash}}
  end

  def terminate(_reason, {current_number, pid_stash}) do
    Sequence.Stash.save_value(pid_stash, current_number)
  end

  def handle_call(:next_number, _from, {current_number, pid_stash}) do
    next_number = current_number + 1
    {:reply, next_number, {next_number, pid_stash}}
  end

  def handle_call(:current, _from, {current_number, pid_stash}) do
    {:reply, current_number, {current_number, pid_stash}}
  end

  def handle_call({:set_number, new_number}, _from, {_current_number, pid_stash}) do
    {:reply, new_number, {new_number, pid_stash}}
  end

  def handle_cast({:increment_number, delta}, {current_number, pid_stash}) do
    {:noreply, {current_number + delta, pid_stash}}
  end
end
