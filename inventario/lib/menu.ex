defmodule Menu do

  def iniciar do
    productos = ArchivoJSON.cargar()
    loop(productos)
  end

  def loop(productos) do
    IO.puts("\n=== MENÚ INVENTARIO ===")
    IO.puts("1. Agregar producto")
    IO.puts("2. Listar productos")
    IO.puts("3. Eliminar producto")
    IO.puts("4. Bajo stock")
    IO.puts("5. Producto más caro")
    IO.puts("6. Valor total inventario")
    IO.puts("0. Salir")

    opcion = IO.gets("Seleccione: ") |> String.trim()

    case opcion do
      "1" -> loop(agregar(productos))
      "2" -> listar(productos); loop(productos)
      "3" -> loop(eliminar(productos))
      "4" -> bajo_stock(productos); loop(productos)
      "5" -> mas_caro(productos); loop(productos)
      "6" -> total(productos); loop(productos)
      "0" -> IO.puts("Adiós")
      _ -> IO.puts("Opción inválida"); loop(productos)
    end
  end

  # ---------------- FUNCIONES ----------------

  def agregar(productos) do
    codigo = IO.gets("Código: ") |> String.trim()
    nombre = IO.gets("Nombre: ") |> String.trim()
    precio = IO.gets("Precio: ") |> String.trim() |> String.to_integer()
    cantidad = IO.gets("Cantidad: ") |> String.trim() |> String.to_integer()

    case Inventario.agregar_producto(productos, codigo, nombre, precio, cantidad) do
      {:ok, nuevos} ->
        ArchivoJSON.guardar(nuevos)
        IO.puts("Producto agregado")
        nuevos

      {:error, r} ->
        IO.puts("Error: #{r}")
        productos
    end
  end

  def listar(productos) do
    productos
    |> Map.values()
    |> Enum.each(fn p ->
      IO.puts("#{p.codigo} - #{p.nombre} - $#{p.precio} - Cant: #{p.cantidad}")
    end)
  end

  def eliminar(productos) do
    codigo = IO.gets("Código: ") |> String.trim()

    case Inventario.eliminar_producto(productos, codigo) do
      {:ok, nuevos} ->
        ArchivoJSON.guardar(nuevos)
        IO.puts("Eliminado")
        nuevos

      {:error, _} ->
        IO.puts("No encontrado")
        productos
    end
  end

  def bajo_stock(productos) do
    lista = Inventario.bajo_stock(productos, 5)

    if lista == [] do
      IO.puts("No hay productos con bajo stock")
    else
      Enum.each(lista, fn p ->
        IO.puts("#{p.nombre} - Cantidad: #{p.cantidad}")
      end)
    end
  end

  def mas_caro(productos) do
    case Inventario.producto_mas_caro(productos) do
      nil ->
        IO.puts("No hay productos")

      p ->
        IO.puts("Más caro: #{p.nombre} ($#{p.precio})")
    end
  end

  def total(productos) do
    total = Inventario.valor_total(productos)
    IO.puts("Valor total: $#{total}")
  end

end
