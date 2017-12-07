defmodule HamlSigil do
  def sigil_h(haml, _args) do
    Calliope.render(haml)
  end
end
