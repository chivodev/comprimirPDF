#!/bin/bash

# Script creado por Ch1v0D3v

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

# Lectura de archivo seleccionado
file_input="$@"
# Si el archivo marca error, anulamos el dicho error para evitar conflictos en pantalla
dd if="$file_input" of=/dev/null 2>/dev/null
# Archivo de salida con el mismo nombre, concatenado por compress_
file_output="compress_$file_input"

case $option in
	#Método default
	"Estandar" )
		gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$file_output $file_input
		;;
	#Método screen
	"Screen(Recomendado)" )
		gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$file_output $file_input
		;;
	#Método Ebook
	"Ebook" )
		gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$file_output $file_input
		;;
	#Método printer
	"Printer" )
		gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$file_output $file_input
		;;
	#Método prepress
	"Prepress" )
		gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$file_output $file_input
		;;
	*)
		exit 0
		;;
esac

# Mostramos mensaje de compresion exitosa
zenity --info --title="Mensaje" --text="Archivo $file_input reducido, Archivo $file_output creado exitosamente"