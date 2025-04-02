#!/bin/bash

# Colores para mensajes # Colors for messages
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # Sin color # No color

## Variables
BASE_DIR="$(dirname "$(realpath "$0")")"

# Funcion para imprimir mensajes con formato # Function to print formatted messages
print_message() {
    local type=$1
    local message=$2
    local color
    case $type in
        "info") color=$BLUE ;;
        "success") color=$GREEN ;;
        "warning") color=$YELLOW ;;
        "error") color=$RED ;;
        "header") color=$PURPLE ;;
        "status") color=$CYAN ;;
    esac
    echo -e "${color}######### [System Update] $message${NC}"
}

# Funcion para manejar errores # Function to handle errors
handle_error() {
    local message=$1
    print_message "error" "$message"
    return 1
}

# Funcion para actualizar el sistema # Function to update the system
update_system() {
    print_message "header" "Detectando sistema operativo y actualizando paquetes..."
    print_message "header" "Detecting operating system and updating packages..."

    # Intentar actualizar con apt Debian y derivados, incluido Termux # Try to update with apt on Debian and derivatives, including Termux
    if command -v apt >/dev/null 2>&1; then
        print_message "info" "Sistema basado en Debian detectado. Actualizando con apt..."
        print_message "info" "Debian-based system detected. Updating with apt..."
        if apt update -y && apt upgrade -y --force-yes; then
            print_message "success" "Sistema actualizado correctamente con apt."
            print_message "success" "System successfully updated with apt."
        else
            handle_error "Error al actualizar con apt."
            handle_error "Error updating with apt."
            return 1
        fi
    # Intentar actualizar con pacman. Arch Linux y derivados. # Try to update with pacman. Arch Linux and derivatives.
    elif command -v pacman >/dev/null 2>&1; then
        print_message "info" "Sistema Arch Linux. Actualizando con pacman..."
        print_message "info" "Arch Linux system. Updating with pacman..."
        if pacman -Syu --noconfirm; then
            print_message "success" "Sistema actualizado correctamente con pacman."
            print_message "success" "System successfully updated with pacman."
        else
            handle_error "Error al actualizar con pacman."
            handle_error "Error updating with pacman."
            return 1
        fi
    # Si no hay apt ni pacman se asume que es Windows y se usa Winget y Chocolatey # If neither apt nor pacman are present, assume it's Windows and use Winget and Chocolatey
    else
        print_message "info" "Windows detectado. Actualizando con winget y chocolatey..."
        print_message "info" "Windows detected. Updating with winget and chocolatey..."

        # Actualizar con winget # Update with winget
        if command -v winget >/dev/null 2>&1; then
            print_message "info" "Actualizando con winget..."
            print_message "info" "Updating with winget..."
            if winget upgrade --all; then
                print_message "success" "Sistema actualizado correctamente con winget."
                print_message "success" "System successfully updated with winget."
            else
                handle_error "Error al actualizar con winget."
                handle_error "Error updating with winget."
                ((error_count++))
            fi
        else
            handle_error "winget no esta disponible en este sistema."
            handle_error "winget is not available on this system."
            ((error_count++))
        fi

        # Actualizar con chocolatey # Update with chocolatey
        if command -v choco >/dev/null 2>&1; then
            print_message "info" "Actualizando con chocolatey..."
            print_message "info" "Updating with chocolatey..."
            if choco upgrade all -y; then
                print_message "success" "Sistema actualizado correctamente con chocolatey."
                print_message "success" "System successfully updated with chocolatey."
            else
                handle_error "Error al actualizar con chocolatey."
                handle_error "Error updating with chocolatey."
                ((error_count++))
            fi
        else
            handle_error "Chocolatey no esta disponible en este sistema."
            handle_error "Chocolatey is not available on this system."
            ((error_count++))
        fi
    fi
}

# Funcion para ejecutar el otro script en Linux/Termux # Function to execute the other script on Linux/Termux
run_global_script_linux() {
    print_message "header" "Ejecutando script Linux/Termux..."
    print_message "header" "Executing Linux/Termux script..."
    cd "$BASE_DIR" || return

    if [ ! -f "./all.sh" ]; then
        handle_error "./all.sh no existe."
        handle_error "./all.sh does not exist."
        return 1
    fi

    # Verificar ./all.sh tenga permisos de ejecucion # Verify ./all.sh has execution permissions
    if [ ! -x "./all.sh" ]; then
        print_message "info" "Otorgando permisos de ejecucion a ./all.sh..."
        print_message "info" "Granting execution permissions to ./all.sh..."
        if chmod +x ./all.sh; then
            print_message "success" "Permisos de ejecucion otorgados correctamente."
            print_message "success" "Execution permissions successfully granted."
        else
            handle_error "Error al otorgar permisos de ejecucion a ./all.sh."
            handle_error "Error granting execution permissions to ./all.sh."
            return 1
        fi
    fi

    # Ejecutar ./all.sh # Execute ./all.sh
    if nice -n -0 ./all.sh; then
        print_message "success" "Script global ejecutado correctamente."
        print_message "success" "Global script executed successfully."
    else
        handle_error "Error al ejecutar ./all.sh."
        handle_error "Error executing ./all.sh."
        return 1
    fi
}

# Funcion para ejecutar el script global en Windows # Function to execute the global script on Windows
run_global_script_windows() {
    print_message "header" "Ejecutando script Windows..."
    print_message "header" "Executing Windows script..."
    cd "$BASE_DIR" || return

    if [ ! -f "./allwindows.ps1" ]; then
        handle_error "./allwindows.ps1 no existe."
        handle_error "./allwindows.ps1 does not exist."
        return 1
    fi

    # Ejecutar ./allwindows.ps1 con PowerShell # Execute ./allwindows.ps1 with PowerShell
    if powershell -ExecutionPolicy Bypass -File "./allwindows.ps1"; then
        print_message "success" "Script global ejecutado correctamente."
        print_message "success" "Global script executed successfully."
    else
        handle_error "Error al ejecutar ./allwindows.ps1."
        handle_error "Error executing ./allwindows.ps1."
        return 1
    fi
}

# Funcion principal # Main function
main() {
    local error_count=0
    local successful_updates=0

    print_message "header" "Iniciando proceso de actualizacion del sistema..."
    print_message "header" "Starting system update process..."

    # Actualizar el sistema # Update the system
    update_system && ((successful_updates++)) || ((error_count++))

    # Ejecutar el script global segun el sistema operativo # Execute the global script according to the operating system
    if command -v apt >/dev/null 2>&1 || command -v pacman >/dev/null 2>&1; then
        run_global_script_linux && ((successful_updates++)) || ((error_count++))
    else
        run_global_script_windows && ((successful_updates++)) || ((error_count++))
    fi

    # Resumen final # Final summary
    print_message "header" "Proceso completado"
    print_message "header" "Process completed"
    print_message "status" "Actualizaciones exitosas: $successful_updates"
    print_message "status" "Successful updates: $successful_updates"
    if [ $error_count -eq 0 ]; then
        print_message "success" "Todas las actualizaciones se completaron sin errores."
        print_message "success" "All updates completed without errors."
        return 0
    else
        print_message "warning" "Proceso completado con $error_count errores."
        print_message "warning" "Process completed with $error_count errors."
        return 1
    fi
}

main
