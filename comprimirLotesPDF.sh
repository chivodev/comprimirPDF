#!/bin/bash

# Script creado por Ch1v0D3v
# Uso para todos los archivos dentro del directorio donde se ejecuta

function opciones {
	# Creamos la ventana de dialogo y una escucha a cancelar
	option=$(zenity --width=360 --height=320 --list --title "Elije Método de compresión" --text="Selecciona la calidad que quieres que tenga el PDF" --column $"Metodo" --column $"Calidad" "Estandar" "<72 DPI" "Screen(Recomendado)" "72 DPI" "Ebook" "150 DPI" "Printer" "300 DPI" "Prepress" "300 DPI Preser. Color" || echo Cancel)
}

# Llamamos a la funcion para mostrar dialogo de opciones
opciones

# Si seleccionamos cancelar, salimos del programa
[[ "$option" = "Cancel" ]] && exit

# Si no seleccionamos una opciones volvemos y llamamos a la funcion opciones
if [[ "$option" = "" ]]; then
	zenity --error --text="Método no especificado. Selecciona un método y de click en aceptar. "
	opciones
fi

# Creamos el array vacio
arrayFiles=()
# Leemos todos los archivos pdf del directorio
files=`ls *.pdf`
for file in $files; do
	extension=${file##*.}
	if [[ "$extension" = "pdf" ]]; then
		arrayFiles+=(TRUE "${file}")
	fi
done

# Mostramos todos los archivos del directorio con opcion de checkear
continuar=$(zenity --width=360 --height=320 --list --checklist \
			--title="Lista de archivos PDf a comprimir" --text="Archivos disponibles" \
			--column="Choose" --column="PDF's" "${arrayFiles[@]}" || echo No)

# Si el usuario continua
[[ "$continuar" = "No" ]] && exit

# Calculamos el total de archivos que se comprimiran
totalPDF=0
IFS="|"
for pdf in $continuar; do
	((totalPDF++))
done
IFS=""

# Iniciamos la barra de progreso a mostrar
progreso=0
let "incremento=100/$totalPDF"

# Leemos y ejecutamos compresion de cada archivos
IFS="|"
( for pdf in $continuar; do
	# Realizamos los incrementos de la barra de progreso
	echo "$progreso"
	let "progreso+=$incremento"
	# Lectura de archivo seleccionado
	file_input="$pdf"
	# Archivo de salida con el mismo nombre, concatenado por compress_
	file_output="compress_$file_input"

	filename="${pdf##*/}"
	echo -e "# Transformando: \t ${filename}"
	case $option in
		#Método default
		"Estandar" )
			gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.6 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$file_output $file_input
			;;
		#Método screen
		"Screen(Recomendado)" )
			gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.6 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$file_output $file_input
			;;
		#Método Ebook
		"Ebook" )
			gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.6 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$file_output $file_input
			;;
		#Método printer
		"Printer" )
			gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.6 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$file_output $file_input
			;;
		#Método prepress
		"Prepress" )
			gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.6 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$file_output $file_input
			;;
		*)
			exit 0
			;;
	esac
	let "progreso+=$incremento"
done
) | zenity --progress --width=450 --title "Transformando PDF..." --percentage=0 --auto-close --auto-kill
IFS=""

# Mostramos mensaje de compresion exitosa
zenity --info --title="Compresion Finalizada" --text="Se comprimieron exitosamente $totalPDF archivos."