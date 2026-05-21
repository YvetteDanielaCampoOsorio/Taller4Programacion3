defmodule Inventario do

  def agregar_producto(productos, codigo, nombre, precio, cantidad) do
    case Producto.nuevo(codigo, nombre, precio, cantidad) do
      {:ok, producto} ->
        if Map.has_key?(productos, codigo) do
          {:error, :codigo_duplicado}
        else
          {:ok, Map.put(productos, codigo, producto)}
        end

      {:error, razon} ->
        {:error, razon}
    end
  end

  def actualizar_producto(productos, codigo, nombre, precio, cantidad) do
    case Map.get(productos, codigo) do
      nil ->
        {:error, :no_encontrado}

      _ ->
        actualizado = %Producto{
          codigo: codigo,
          nombre: nombre,
          precio: precio,
          cantidad: cantidad
        }

        {:ok, Map.put(productos, codigo, actualizado)}
    end
  end

  def eliminar_producto(productos, codigo) do
    if Map.has_key?(productos, codigo) do
      {:ok, Map.delete(productos, codigo)}
    else
      {:error, :no_encontrado}
    end
  end

  def listar_productos(productos), do: Map.values(productos)

  def bajo_stock(productos, limite) do
    productos
    |> Map.values()
    |> Enum.filter(fn p -> p.cantidad < limite end)
  end

  def producto_mas_caro(productos) do
    productos
    |> Map.values()
    |> Enum.max_by(fn p -> p.precio end, fn -> nil end)
  end

  def valor_total(productos) do
    productos
    |> Map.values()
    |> Enum.reduce(0, fn p, acc ->
      acc + (p.precio * p.cantidad)
    end)
  end
end
