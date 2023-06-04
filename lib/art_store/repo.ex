defmodule ArtStore.Repo do
  use Ecto.Repo,
    otp_app: :art_store,
    adapter: Ecto.Adapters.Postgres
end
