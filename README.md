# comprimirPDF
Script Bash para comprimir archivos con gestor de archivos Thunar, de forma rapida y sencilla

## Instalar los paquetes necesarios para ejecutar el script
Para poder reducir los archivos pdf es necesario tener instalado los paquetes de zenity y ghostscript. Y el entorno
de escritorio [xfce](https://www.xfce.org/)

### Aqui algunos comandos para instalar de acuerdo a cada distribucion que usen

#### Si usan Debian o derivados
	$ sudo apt-get install zenity ghostscript

#### Si usan Fedora o derivados
	$ sudo dnf install zenity ghostscript

#### Para usuario de OpenSuse
	$ sudo zypper in zenity ghostscript

#### Para aquellos que usan Arch o derivados
	$ sudo pacman -Sy zenity ghostscript

## Aqui crearemos el script
Una vez instalado los paquetes necesarios, es momento de escoger donde guardar el script.
Les recomiendo crear una carpeta donde guardar los script personalizados.

Creamos la carpeta ejecutando el siguiente comando
	$ mkdir ~/config/Thunar/customScripts
