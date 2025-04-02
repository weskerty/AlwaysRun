# AlwaysRun
![English](https://img.shields.io/badge/Language-English-blue) Script checks another script has stopped.  
![Español](https://img.shields.io/badge/Idioma-Español-red) Script que verifica si otro script se detuvo.

## ALL.SH
![English](https://img.shields.io/badge/Language-English-blue)
This script runs scripts in alphabetical order within the script folder, which is located in the same location as this script (all.sh).
1Redis.sh or ARedis.sh will be started first. To prevent a script from running, change the sh extension, for example, 1Redis.sh.off

![Español](https://img.shields.io/badge/Idioma-Español-red)
Este script inicia scripts en orden alfabético dentro de la carpeta script que esta ubicada en el mismo lugar que este script (all.sh)
Se iniciara primero 1Redis.sh o ARedis.sh. Para evitar que un script se ejecute cambie la extension sh, ejemplo 1Redis.sh.off 

No Work on Windows. Reiniciara procesos infinitamente por que no puede localizar el script en ejecucion.

## UPDATE.SH
![English](https://img.shields.io/badge/Language-English-blue)
This option is optional and serves to update the system where the script is running. On Linux, it works with APT on Debian and derivatives (including Termux) or Pacman on Arch and Arch-based systems.
If you're using Windows, it will update Winget and Chocolatey.
After the update, launch ALL.SH on Linux or all.ps1 on Windows.

![Español](https://img.shields.io/badge/Idioma-Español-red)
Esta opción es opcional y sirve para actualizar el sistema donde se ejecuta el script. En Linux Funciona con APT en Debian y derivados (incluido Termux) o Pacman en Arch y sistemas basados en el.
Si usas Windows Actualizara Winget y Chocolatey
Después de la actualización, inicia ALL.SH en Linux o all.ps1 en Windows.

### SystemD
![English](https://img.shields.io/badge/Language-English-blue)



![Español](https://img.shields.io/badge/Idioma-Español-red)
