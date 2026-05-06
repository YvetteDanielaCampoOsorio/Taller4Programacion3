# Sistema de Gimnasio e Inventario

## Descripción

Este proyecto contiene dos sistemas desarrollados en Elixir:

1. Sistema de Gimnasio
   - Permite gestionar socios
   - Inscribir y desinscribir en clases
   - Guardar información en archivo CSV

2. Sistema de Inventario
   - Permite gestionar productos
   - Consultar stock, producto más caro y valor total
   - Guardar información en archivo JSON

## Cómo ejecutar

1. Entrar al proyecto:

   cd nombre_del_proyecto

2. Ejecutar en consola:

   iex.bat -S mix

3. Iniciar el menú:

   Menu.iniciar()

## Archivos importantes

- socios.csv → guarda los datos del gimnasio
- productos.json → guarda los datos del inventario

## Funcionalidades principales

Gimnasio:
- Crear, eliminar y buscar socios
- Inscribir y desinscribir en clases
- Ver socios por clase
- Persistencia en CSV

Inventario:
- Agregar y eliminar productos
- Consultar bajo stock
- Ver producto más caro
- Calcular valor total
- Persistencia en JSON

## Notas

- Los datos se guardan automáticamente después de cada operación
- Se manejan errores básicos como duplicados o datos inválidos
- Se usan funciones de Enum para las consultas

## Reflexión sobre el uso de IA

La inteligencia artificial se utilizó como una herramienta de apoyo durante el desarrollo del taller, principalmente como una guía similar a la de un profesor. Fue útil para aclarar dudas sobre funciones, métodos y estructuras del lenguaje que no eran completamente comprendidas, así como para orientar el proceso de construcción de las soluciones.

Sin embargo, el desarrollo del código no se limitó a copiar respuestas, sino que se buscó entender cada parte, probarla y adaptarla según lo requerido en el taller. De esta manera, la IA sirvió como un complemento al aprendizaje, facilitando la comprensión de conceptos y la resolución de problemas.