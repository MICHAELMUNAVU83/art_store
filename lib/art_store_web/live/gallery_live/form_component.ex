defmodule ArtStoreWeb.GalleryLive.FormComponent do
  use ArtStoreWeb, :live_component

  alias ArtStore.Galleries

  @impl true
  def update(%{gallery: gallery} = assigns, socket) do
    changeset = Galleries.change_gallery(gallery)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:uploaded_files, [])
     |> allow_upload(:image, accept: ~w(.jpg .png .jpeg), max_entries: 2)}
  end

  @impl true
  def handle_event("validate", %{"gallery" => gallery_params}, socket) do
    changeset =
      socket.assigns.gallery
      |> Galleries.change_gallery(gallery_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :image, ref)}
  end

  def handle_event("save", %{"gallery" => gallery_params}, socket) do
    save_gallery(socket, socket.assigns.action, gallery_params)
  end

  defp save_gallery(socket, :edit, gallery_params) do
    case Galleries.update_gallery(socket.assigns.gallery, gallery_params) do
      {:ok, _gallery} ->
        {:noreply,
         socket
         |> put_flash(:info, "Gallery updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_gallery(socket, :new, gallery_params) do
    case Galleries.create_gallery(gallery_params) do
      {:ok, _gallery} ->
        {:noreply,
         socket
         |> put_flash(:info, "Gallery created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
