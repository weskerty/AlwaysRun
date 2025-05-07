#!/bin/bash
# Carpeta de scripts
carpeta="$(dirname "$(realpath "$0")")/script"

###No Cambiar###
ejecutando=true
################


manejar_senal() {
    echo "Recibiendo señal de terminación"
    
    echo "Ejecutando comandos de detención..."
    #Comados Personalizados
    #pm2 stop all    
    #redis-cli shutdown
    
    # Enviar SIGINT a todos los hijos
    cd "$carpeta" || exit 1
    for script in *.sh; do
        echo "Enviando SIGINT a los procesos de $script"
        pkill -SIGINT -f "$script"
    done
    
    # Esperar hasta 20 segundos para que terminen los procesos
    contador=0
    while [ $contador -lt 20 ]; do
        procesos_activos=false
        
        for script in *.sh; do
            if pgrep -f "$script" >/dev/null; then
                procesos_activos=true
                break
            fi
        done
        
        if ! $procesos_activos; then
            echo "Todos los procesos terminaron correctamente"
            break
        fi
        
        sleep 1
        contador=$((contador+1))
        echo "Esperando que los procesos terminen: $contador s..."
    done
    
    # enviar SIGTERM despues de
    for script in *.sh; do
        if pgrep -f "$script" >/dev/null; then
            echo "Los procesos de $script no respondieron a SIGINT, enviando SIGTERM"
            pkill -SIGTERM -f "$script"
        fi
    done
    

    echo "Finalizando..."
    # Comandos Personalizados:
    #echo Organizando && "$carpeta"/Otros/Organize.sh
    
    ejecutando=false
    echo "Terminando. Bye."
}

# Registrar 
trap manejar_senal SIGTERM SIGINT

matar_script() {
    pkill -SIGINT -f "$1"  # Envía SIGINT primero
    sleep 7
    pkill -SIGTERM -f "$1"  # Envía SIGTERM despues de un momento
    echo "Procesos $1 y relacionados terminados."
}

iniciar_script() {
    bash "$1" &  # Inicia el script en segundo plano
    echo "$1 iniciado."
}

# reiniciar script
reiniciar_script() {
    matar_script "$1"  
    sleep 3  # Esperar 3 segundos antes de reiniciar
    iniciar_script "$1"
}

main() {
    cd "$carpeta" || exit 1  # Salir si la carpeta no existe
    
    for script in *.sh; do
        reiniciar_script "$script"
    done
    
    while $ejecutando; do
        for script in *.sh; do
            if ! pgrep -f "$script" >/dev/null; then  # Verificar si el script se detuvo
                echo "$script se detuvo. Reiniciando..."
                reiniciar_script "$script"
            fi
        done
        sleep 30  
    done
}

main
