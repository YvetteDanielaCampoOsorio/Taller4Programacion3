defmodule Producto do
  @enforce_keys [:codigo, :nombre, :precio, :cantidad]
  @derive Jason.Encoder
  defstruct [:codigo, :nombre, :precio, :cantidad]

  def nuevo(codigo, nombre, precio, cantidad) do
    cond do
      not is_binary(codigo) ->
        {:error, :codigo_invalido}

      String.length(codigo) > 5 ->
        {:error, :codigo_largo}

      not (nombre =~ ~r/^[a-zA-Z\s]+$/) ->
        {:error, :nombre_invalido}

      precio < 0 ->
        {:error, :precio_invalido}

      not is_integer(cantidad) or cantidad < 0 ->
        {:error, :cantidad_invalida}

      true ->
        {:ok,
         %Producto{
           codigo: codigo,
           nombre: nombre,
           precio: precio,
           cantidad: cantidad
         }}
    end
  end
end
