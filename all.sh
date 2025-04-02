#!/bin/bash

# Carpeta de scripts que seran Ejecutados -  Folder scripts will be executed
carpeta="$(dirname "$(realpath "$0")")/script"

# Funcion para matar el script y procesos similares - Function to kill script and similar processes
matar_script() {
    pkill -f "$1"  # Mata todos los procesos que coinciden con el nombre del script
    pkill -f "${1%.*}"  # Mata procesos con nombres similares sin la extensión .sh
    echo "Procesos $1 y relacionados terminados."
}

# Funcion para iniciar los script
iniciar_script() {
    bash "$1" &  # Inicia el script en segundo plano
    echo "$1 iniciado."
}

# Funcion para reiniciar el script
reiniciar_script() {
    matar_script "$1"  # Matar instancias previas
    sleep 10  # Esperar 3 segundos antes de reiniciar
    iniciar_script "$1"
}

# Funcion 1 reinicia todos los scripts
main() {
    cd "$carpeta" || exit 1  # Salir si la carpeta no existe
    for script in *.sh; do
        reiniciar_script "$script"
    done

    while true; do
        for script in *.sh; do
            if ! pgrep -f "${script%.*}" >/dev/null; then  # Verificar si el script o similares se detuvieron
                echo "$script se detuvo. Reiniciando..."
                reiniciar_script "$script"
            fi
        done
        sleep 30  # Espera para la Deteccion - Checking time
    done
}

main

# el script inicia scripts en orden alfabético dentro de la carpeta script que esta ubicada en el mismo lugar que este script (all.sh)
# Se iniciara primero 1Redis.sh o ARedis.sh. Para evitar que un script se ejecute cambie la extension sh, ejemplo 1Redis.sh.off 

# The script runs scripts in alphabetical order within the script folder, which is located in the same location as this script (all.sh).
# 1Redis.sh or ARedis.sh will be started first. To prevent a script from running, change the sh extension, e.g., 1Redis.sh.off.
