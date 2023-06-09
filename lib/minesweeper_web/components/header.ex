defmodule MinesweeperWeb.Components.Header do
  use Phoenix.Component

  def header_game(assigns) do
    ~L"""
    <header class="flex justify-around content-center h-14 bg-gray-500">
      <span class="text-2xl flex content-center items-center">🚩<%= @game.total_bombs %></span>

      <button class="text-2xl" phx-click="new_game">
        <%= if @game.game_win? do %>
          🎉
        <% else %>
          <%= if not @game.game_finished? do %>
            😀
          <% else %>
            😫
          <% end %>
        <% end %>

      </button>

      <span class="text-2xl flex content-center items-center"><%= @game.clock.time %></span>
    </header>
    """
  end
end
