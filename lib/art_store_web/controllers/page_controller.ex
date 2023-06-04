defmodule ArtStoreWeb.PageController do
  use ArtStoreWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
