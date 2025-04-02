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

> [!WARNING]
> No Work on Windows. Reiniciara procesos infinitamente por que no puede localizar el script en ejecucion.

### UPDATE.SH
![English](https://img.shields.io/badge/Language-English-blue)
This option is optional and serves to update the system where the script is running. On Linux, it works with APT on Debian and derivatives (including Termux) or Pacman on Arch and Arch-based systems.
If you're using Windows, it will update Winget and Chocolatey.
After the update, launch ALL.SH on Linux or all.ps1 on Windows.
assumed to be Root

![Español](https://img.shields.io/badge/Idioma-Español-red)
Esta opción es opcional y sirve para actualizar el sistema donde se ejecuta el script. En Linux Funciona con APT en Debian y derivados (incluido Termux) o Pacman en Arch y sistemas basados en el.
Si usas Windows Actualizara Winget y Chocolatey
Después de la actualización, inicia ALL.SH en Linux o all.ps1 en Windows.
Se asume que eres Root

### SystemD
![English](https://img.shields.io/badge/Language-English-blue)
This is a service for Linux systems with SystemD. It will automatically run the update.sh script when the PC is turned on (you can change it).
It is placed in `/etc/systemd/system/` and then activated with:
```
systemctl enable UpdateAll.service
```
You can view the service log with:
```
journalctl -u UpdateAll.service -f
```
In Windows you can create a Task with the "Task Scheduler" and set it to start when the PC starts before starting a User (this way CMD windows do not open)

![Español](https://img.shields.io/badge/Idioma-Español-red)
Esto es un Servicio para sistemas Linux con SystemD, hara que al encender la PC se ejecute automaticamente el Script update.sh (puedes cambiarlo).
Se coloca en `/etc/systemd/system/` y luego se activa con:
```
systemctl enable UpdateAll.service
```
Puedes ver el log del servicio con:
```
journalctl -u UpdateAll.service -f
```
En Windows se puede crear una Tarea con el "Programador de Tareas" y Ajustarlo para que inicie al iniciar la PC antes de iniciar un Usuario (de esta manera no se abren ventanas CMD)
