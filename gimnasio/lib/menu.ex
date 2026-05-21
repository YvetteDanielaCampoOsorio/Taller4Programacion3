defmodule Menu do

  def iniciar do
    socios = GestionArchivos.cargar_socios()
    loop(socios)
  end

  def loop(socios) do
    IO.puts("\n=== MENÚ GIMNASIO ===")
    IO.puts("1. Crear socio")
    IO.puts("2. Listar socios")
    IO.puts("3. Buscar socio")
    IO.puts("4. Eliminar socio")
    IO.puts("5. Inscribir a clase")
    IO.puts("6. Desinscribir de clase")
    IO.puts("7. Ver clases de un socio")
    IO.puts("8. Socios por clase")
    IO.puts("0. Salir")

    opcion = IO.gets("Seleccione: ") |> String.trim()

    case opcion do
      "1" -> loop(crear_socio(socios))
      "2" -> listar_socios(socios); loop(socios)
      "3" -> buscar_socio(socios); loop(socios)
      "4" -> loop(eliminar_socio(socios))
      "5" -> loop(inscribir_clase(socios))
      "6" -> loop(desinscribir_clase(socios))
      "7" -> ver_clases(socios); loop(socios)
      "8" -> socios_por_clase(socios); loop(socios)
      "0" -> IO.puts("Adiós")
      _ -> IO.puts("Opción inválida"); loop(socios)
    end
  end

  # ---------------- FUNCIONES ----------------

  def crear_socio(socios) do
    cedula = IO.gets("Cédula: ") |> String.trim()
    nombre = IO.gets("Nombre: ") |> String.trim()
    edad = IO.gets("Edad: ") |> String.trim() |> String.to_integer()

    case Gimnasio.agregar_socio(socios, cedula, nombre, edad) do
      {:ok, nuevos} ->
        IO.puts("Socio creado")
        nuevos

      {:error, r} ->
        IO.puts("Error: #{r}")
        socios
    end
  end

  def listar_socios(socios) do
    Enum.each(Map.values(socios), fn s ->
      IO.puts("#{s.nombre} - #{s.edad}")
    end)
  end

  def buscar_socio(socios) do
    cedula = IO.gets("Cédula: ") |> String.trim()

    case Gimnasio.obtener_socio(socios, cedula) do
      {:ok, s} ->
        IO.puts("Nombre: #{s.nombre}")
        IO.puts("Edad: #{s.edad}")
        IO.puts("Clases: #{Enum.join(s.clases, ", ")}")

      {:error, _} ->
        IO.puts("No encontrado")
    end
  end

  def eliminar_socio(socios) do
    cedula = IO.gets("Cédula: ") |> String.trim()

    case Gimnasio.eliminar_socio(socios, cedula) do
      {:ok, nuevos} ->
        GestionArchivos.guardar_socios(nuevos)
        IO.puts("Eliminado")
        nuevos

      {:error, _} ->
        IO.puts("No encontrado")
        socios
    end
  end

  def inscribir_clase(socios) do
    cedula = IO.gets("Cédula: ") |> String.trim()
    clase = IO.gets("Clase: ") |> String.trim()

    case Gimnasio.inscribir_clase(socios, cedula, clase) do
      {:ok, nuevos} ->
        GestionArchivos.guardar_socios(nuevos)
        IO.puts("Inscrito")
        nuevos

      {:error, r} ->
        IO.puts("Error: #{r}")
        socios
    end
  end

  def desinscribir_clase(socios) do
    cedula = IO.gets("Cédula: ") |> String.trim()
    clase = IO.gets("Clase: ") |> String.trim()

    case Gimnasio.desinscribir_clase(socios, cedula, clase) do
      {:ok, nuevos} ->
        GestionArchivos.guardar_socios(nuevos)
        IO.puts("Desinscrito")
        nuevos

      {:error, _} ->
        IO.puts("Error")
        socios
    end
  end

  def ver_clases(socios) do
    cedula = IO.gets("Cédula: ") |> String.trim()

    case Gimnasio.obtener_socio(socios, cedula) do
      {:ok, s} ->
        IO.puts("Clases: #{Enum.join(s.clases, ", ")}")

      {:error, _} ->
        IO.puts("No encontrado")
    end
  end

  def socios_por_clase(socios) do
  clase = IO.gets("Clase: ") |> String.trim()

  resultado =
    socios
    |> Map.values()
    |> Enum.filter(fn s -> clase in s.clases end)

  if resultado == [] do
    IO.puts("No hay socios inscritos en esa clase")
  else
    Enum.each(resultado, fn s -> IO.puts(s.nombre) end)
  end
end

end
