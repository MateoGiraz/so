#!/bin/bash

option=0

while [ $option -ne 5 ] ; do
clear
echo "Seguros ConductORT"
echo "1) Registrar Matricula"
echo "2) Ver Matriculas Registradas"
echo "3) Buscar Matriculas por Usuario"
echo "4) Cambiar Permiso de Modificacion"
echo "5) Salir"
echo
read -p "Seleccione una opcion: " option

case $option in
	1) clear
		read -p "Ingrese la matricula: " matricula
		if [[  $matricula =~ ^S{1}[BCDFGHJKLMNPRSTVWXYZ]{2}-[0-9]{4}$ ]]; then
			echo "matricula valida"
			read -p "Ingrese la cedula del responsable: " ci
			if [[ $ci =~ [0-9]{1}.[0-9]{3}.[0-9]{3}-[0-9]{1}$  ]]; then
				read -p "Ingrese fecha de vencimiento (YYYY-MM-DD): " date
				echo "$matricula | $ci | $date" >> matriculas.txt
				echo "Operacion exitosa"
			else
				echo "Cedula invalida"
				sleep 2	
			fi
		else
			echo -e "matricula invalida"
			sleep 2
		fi
		;;
	2) clear
		echo "Matriculas registradas: "
		while IFS= read -r line
		do
			echo $line
		done < matriculas.txt
		sleep 2
		;;
	3) clear
		echo "op3"
		sleep 2
		;;
	4) clear
		echo "op4"
		sleep 2
		;;
	5) clear
		echo "op5"
		;;
	*) clear
		echo "invalid op"
		sleep 2
		;;
esac
done

 
