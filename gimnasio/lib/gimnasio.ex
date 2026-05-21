defmodule Gimnasio do

  def agregar_socio(socios, cedula, nombre, edad) do
    case Socio.nuevo(nombre, edad) do
      {:ok, nuevo_socio} ->
        if Map.has_key?(socios, cedula) do
          {:error, :cedula_duplicada}
        else
          nuevos_socios = Map.put(socios, cedula, nuevo_socio)
          GestionArchivos.guardar_socios(nuevos_socios)
          {:ok, nuevos_socios}
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

  def desinscribir_clase(socios, cedula, clase) do
    case Map.get(socios, cedula) do
      nil ->
        {:error, :no_encontrado}

      socio ->
        case Socio.desinscribir_clase(socio, clase) do
          {:ok, actualizado} ->
            {:ok, Map.put(socios, cedula, actualizado)}
        end
    end
  end
end
