defmodule ArtStore.Repo.Migrations.AddArtImageToGalleries do
  use Ecto.Migration

  def change do
    alter table(:galleries) do
      add(:art_image, :string)
    end
  end
end
