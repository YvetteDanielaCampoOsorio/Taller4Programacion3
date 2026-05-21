defmodule Socio do
  @enforce_keys [:nombre, :edad]
  defstruct [:nombre, :edad, clases: []]

  def nuevo(nombre, edad) when edad > 0 and edad < 100 do
    {:ok, %__MODULE__{nombre: nombre, edad: edad}}
  end

  def nuevo(_, _), do: {:error, :edad_invalida}

  def inscribir_clase(%__MODULE__{clases: clases} = socio, clase) do
    if tiene_clase?(socio, clase) do
      {:error, :ya_inscrito}
    else
      {:ok, %{socio | clases: [clase | clases]}}
    end
  end

  def desinscribir_clase(%__MODULE__{clases: clases} = socio, clase) do
    {:ok, %{socio | clases: List.delete(clases, clase)}}
  end

  def tiene_clase?(%__MODULE__{clases: clases}, clase),
    do: Enum.member?(clases, clase)
end


defmodule Gimnasio do

  def agregar_socio(socios, cedula, nombre, edad) do
    case Socio.nuevo(nombre, edad) do
      {:ok, nuevo_socio} ->
        if Map.has_key?(socios, cedula) do
          {:error, :cedula_duplicada}
        else
          {:ok, Map.put(socios, cedula, nuevo_socio)}
        end

      {:error, razon} ->
        {:error, razon}
    end
  end

  def obtener_socio(socios, cedula) do
    case Map.get(socios, cedula) do
      nil -> {:error, :no_encontrado}
      socio -> {:ok, socio}
    end
  end

  def eliminar_socio(socios, cedula) do
    if Map.has_key?(socios, cedula) do
      {:ok, Map.delete(socios, cedula)}
    else
      {:error, :no_encontrado}
    end
  end

  def inscribir_clase(socios, cedula, clase) do
    case Map.get(socios, cedula) do
      nil ->
        {:error, :no_encontrado}

      socio ->
        case Socio.inscribir_clase(socio, clase) do
          {:ok, actualizado} ->
            {:ok, Map.put(socios, cedula, actualizado)}

          {:error, razon} ->
            {:error, razon}
        end
    end
  end

  def listar_socios(socios), do: Map.values(socios)

end

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

end
