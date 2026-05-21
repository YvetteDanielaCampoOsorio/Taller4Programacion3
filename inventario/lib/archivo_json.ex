defmodule ArchivoJSON do

  def guardar(productos) do
    datos =
      productos
      |> Map.values()

    json = Jason.encode!(datos)
    File.write("productos.json", json)
  end

  def cargar do
    case File.read("productos.json") do
      {:ok, contenido} ->
        contenido
        |> Jason.decode!()
        |> convertir_a_map()

      {:error, _} ->
        File.write("productos.json", "[]")
        %{}
    end
  end

  # ---------------- AUXILIAR ----------------

  defp convertir_a_map(lista) do
    lista
    |> Enum.map(fn prod ->
      producto = %Producto{
        codigo: prod["codigo"],
        nombre: prod["nombre"],
        precio: prod["precio"],
        cantidad: prod["cantidad"]
      }

      {producto.codigo, producto}
    end)
    |> Enum.into(%{})
  end

end
