# Obligatorio SO
## Parte 1. Bash Scripting
Realizar un script de bash, se detallan las funcionalidades a continuación.
- Registrar Matrículas.
- Ver Matrículas Registradas.
- Buscar Matrículas por Usuario.
- Cambiar Permiso de Modificación.
- Salir.

## Parte 2. POSIX
Realiza en C con POSIX un programa que al ejecutarse muestre en pantalla los nodos del
siguiente grafo (respetando su preferencia y la posibilidad de realizar concurrentemente
algunos nodos)

![image](https://user-images.githubusercontent.com/100039777/208145313-e9feecee-1bea-4a53-9e7b-5103eb12e101.png)

## Parte 3. ADA
Se desea simular el funcionamiento de un puerto para barcos de contenedores.
En dicho puerto existe una grúa de descarga (con capacidad de 2 barcos) y 2 lugares de
atracadero de espera (el quinto espera sin atracar).

- Una vez que descargan, deben irse.
- De existir lugar en la grúa, no tienen que ir primero a esperar.
- Existen 10 barcos que intentan entrar al puerto (numerados de 1 a 10).
  - Antes de intentar entrar a puerto, esperan un random de 1 a 10 segundos.
  - Inicialmente, todos los barcos están llenos.
  - Una vez descargado, no intenta volver a puerto.
- No pueden acceder más de 5 barcos a la vez al puerto.
- No pueden coincidir dos barcos en el mismo atracadero de espera o en la misma grúa.
- Anunciar implica mostrar en consola.

## Parte 4. Docker
se corre un bash en máquinas virtuales, de las cuales los precios de mantenimiento y las licencias son elevados.
Se nos pide encontrar una forma de abaratar costos.
Se les pide realizar una imagen de docker para el bash dado.
