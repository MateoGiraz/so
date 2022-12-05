#!/bin/bash

option1_handler () {
	
	read -p "Ingrese la matricula: " matricula
	if [[ ! $matricula =~ ^S{1}[BCDFGHJKLMNPRSTVWXYZ]{2}-[0-9]{4}$ ]]; then
		clear
		echo "matricula invalida"
		sleep 2
		return 
	fi
	
	read -p "Ingrese la cedula del responsable: " ci	
	if [[ ! $ci =~ [0-9]{1}.[0-9]{3}.[0-9]{3}-[0-9]{1}$  ]]; then
		clear
		echo "Cedula invalida"
		sleep 2
		return
	fi
	
	read -p "Ingrese fecha de vencimiento (YYYY-MM-DD): " date
	if [[ ! $date =~ [0-9]{4}-[0-9]{2}-[0-9]{2}$  ]]; then
		clear
		echo "Fecha invalida"
		sleep 2
		return
	fi
	
	CURRENT_FILE=main.sh
	if [ ! -w "$CURRENT_FILE" ]; then
		echo "La operación no será guardada porque el usuario no tiene permisos de administrador"
		return
	fi
	
	echo "$matricula | $ci | $date" >> matriculas.txt
	echo "Registro: $matricula | $ci | $date" >> log$fn.txt
	echo "Operacion exitosa"
	sleep 1

}

option2_handler () {
	
	if [ ! -e matriculas.txt ]; then
		clear
		echo "No hay matriculas registradas"
		sleep 1
		return
	fi

	today=$(date +%F)

	echo "Matriculas registradas: "
		while IFS= read -r line
		do
			savedDay=${line:24}
			if [[ $savedDay > $today ]]; then
				echo "${line:0:22} | En Orden"
				echo "Consulta: ${line:0:22} | En Orden" >> log$fn.txt
			else
				echo "${line:0:22} | Vencida"
				echo "Consulta: ${line:0:22} | Vencida" >> log$fn.txt
			fi
		done < matriculas.txt
		sleep 5
}

option3_handler () {
	
	if [ ! -e matriculas.txt ]; then
		clear
		echo "No hay matriculas registradas"
		sleep 1
		return
	fi

	read -p "Ingrese cedula a buscar: " ci	
	if [[ ! $ci =~ [0-9]{1}.[0-9]{3}.[0-9]{3}-[0-9]{1}$  ]]; then
		clear
		echo "Cedula invalida"
		sleep 2
		return
	fi
	echo "Se consulto por la cedula: $ci" >> log$fn.txt
	matCount=0
	while IFS= read -r line	
		do
			if [[ "$line" == *"$ci"* ]]; then
				echo ${line:0:9}
				matCount=$((matCount+1))
			fi
		done < matriculas.txt
	echo "Hay $matCount matrícula/s asociadas al usuario"
	sleep 5

}

option4_handler () {

clear
echo "1) Bloquear modificaciones"
echo "2) Permitir modificaciones"

read permissionOption

case $permissionOption in
	1) clear
		sudo chmod -w matriculas.txt
		echo "Modificación realizada correctamente"
		echo "Se cambió permiso de modificación a solo lectura" >> log$fn.txt
		sleep 2
		;;
	2) clear
		sudo chmod +w matriculas.txt
		echo "Modificación realizada correctamente"
		echo "Se cambió permiso de modificación a lectura y escritura " >> log$fn.txt
		sleep 2
		;;
	*) clear
		echo "invalid op"
		sleep 2
		;;
esac

}

option=0
STATUS_FILE=last.txt

if [ ! -d "logs" ]; then
	mkdir logs
fi

if [[ ! -f "$STATUS_FILE" ]]; then
	echo "0" >> $STATUS_FILE
fi

num=$(cat $STATUS_FILE)
fn=$((num+1))
echo $fn > $STATUS_FILE

while [ $option -ne 5 ] ; do
clear
echo "Seguros ConductORT"
echo "1) Registrar Matricula"
echo "2) Ver Matriculas Registradas"
echo "3) Buscar Matriculas por Usuario"
echo "4) Cambiar Permiso de Modificacion"
echo "5) Salir"
read -p "Seleccione una opcion: " option

case $option in
	1) clear
		option1_handler
		;;
	2) clear
		option2_handler
		;;
	3) clear
		option3_handler
		;;
	4) clear
		option4_handler
		;;
	5) clear
		mv log$fn.txt ./logs
		;;
	*) clear
		echo "invalid op"
		sleep 2
		;;
esac
done
