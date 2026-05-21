defmodule GestionArchivos do
  def leer_archivo do
    case File.read("socios.csv") do
      {:ok, contenido} ->
        contenido

      {:error, _} ->
        File.write("socios.csv", "")
        ""
    end
  end

  def cargar_lineas do
    leer_archivo()
    |> String.split("\n", trim: true)
  end

  def linea_a_socio(linea) do
    [cedula, nombre, edad, clases] = String.split(linea, ",")

    clases_lista =
      if clases == "" do
        []
      else
        String.split(clases, ";")
      end

    socio = %Socio{
      nombre: nombre,
      edad: String.to_integer(edad),
      clases: clases_lista
    }

    {cedula, socio}
  end

  def cargar_socios do
    cargar_lineas()
    |> Enum.map(&linea_a_socio/1)
    |> Enum.into(%{})
  end

  def socio_a_linea({cedula, %Socio{nombre: nombre, edad: edad, clases: clases}}) do
    clases_str = Enum.join(clases, ";")
    "#{cedula},#{nombre},#{edad},#{clases_str}"
  end

  def guardar_socios(socios) do
  contenido =
    socios
    |> Enum.map(&socio_a_linea/1)
    |> Enum.join("\n")

  File.write("socios.csv", contenido)
end
end
