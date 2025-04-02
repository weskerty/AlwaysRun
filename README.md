# AlwaysRun
Script checks another script has stopped. - Script que verifica si otro script se detuvo.

## ALL.SH
This script runs scripts in alphabetical order within the script folder, which is located in the same location as this script (all.sh).
1Redis.sh or ARedis.sh will be started first. To prevent a script from running, change the sh extension, for example, 1Redis.sh.off

Este script inicia scripts en orden alfabético dentro de la carpeta script que esta ubicada en el mismo lugar que este script (all.sh)
Se iniciara primero 1Redis.sh o ARedis.sh. Para evitar que un script se ejecute cambie la extension sh, ejemplo 1Redis.sh.off 

## UPDATE.SH


Esto es opcional y sirve sirve para actualizar el sistema en donde se ejecuta el Script. Prueba APT para Debian y Basados (incluido termux) y Arch y Basados. Si no es Linux intenta actualizar Winget y Chocolatey (ejecucion con la terminal git, no lo probe.)
Luego de eso inicia
