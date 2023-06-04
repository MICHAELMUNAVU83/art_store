defmodule ArtStore.Repo.Migrations.CreateGalleries do
  use Ecto.Migration

  def change do
    create table(:galleries) do
      add :name, :string
      add :author, :string

      timestamps()
    end
  end
end
