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
Una vez instalado los paquetes necesarios, procedemos a seguir los pasos a continuación.

1. Creamos la carpeta ejecutando el siguiente comando

		$ mkdir ~/config/Thunar/customScripts

2. A continuacion creamos el archivo donde pegar el codigo

		$ nano ~/config/Thunar/customScripts/comprimirPDF

3. Luego que se abra el editor pegan el codigo del script comprimirPDF.sh, alli encontraras cada linea documentada

4. Luego de pegada (ctrl + shift + v) la informacion, guardamos ( ctrl + o ), y cerramos ( ctrl + x ) el editor

5. Ahora otorgamos permisos de ejecucion al script

		$ sudo chmod +x ~/config/Thunar/customScripts/comprimirPDF

# Creamos la accion personalizada en gestor de archivos Thunar
Ahora procedemos con los pasos para crear un accion personalizada en Thunar.
Para ellos abrimos el gestor de archivos Thunar.

1. Damos click en Editar y luego en Configurar acciones personalizadas...

	![ScreenShot 1](screenshots/screenshot_1.png)