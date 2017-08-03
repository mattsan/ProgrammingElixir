defmodule AllCallbacks.Server do
  use GenServer

  @vsn 3

  def start do
    GenServer.start_link(__MODULE__, 0, name: __MODULE__)
  end

  def next do
    GenServer.call(__MODULE__, :next)
  end

  def set(state) do
    GenServer.cast(__MODULE__, {:set, state})
  end

  def stop do
    GenServer.stop(__MODULE__, :normal)
  end

  def code_change(old_vsn, state, extra) do
    IO.puts """
      変わた
      古い版は #{old_vsn}
      状態は #{state}
      それから #{extra}
      """
    {:ok, state}
  end

  def format_status(reason, pdict_and_state) do
    [formatted_status: [msg: "フォーマった", reason: reason, pdict_and_state: pdict_and_state]]
  end

  def handle_call(:next, _from, state) do
    next_state = state + 1
    IO.puts """
      次った
      今の状態は #{state}
      次の状態は #{next_state}
      """
    {:reply, state, next_state}
  end

  def handle_cast({:set, new_state}, _state) do
    IO.puts """
      設定したった
      新しい状態は #{new_state}
      """
    {:noreply, new_state}
  end

#   def handle_info(msg, state) do
#   end

  def init(args) do
    IO.puts """
      初期化った
      引数は #{args}
      """
    {:ok, args}
  end

  def terminate(reason, state) do
    IO.puts """
      終わた
      理由は #{reason}
      状態は #{state}
      """
    reason
  end
end
