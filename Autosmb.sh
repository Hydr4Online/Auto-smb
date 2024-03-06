#!/bin/bash

# by Hydr4Online

clear

greenCl="\e[0;32m\033[1m"
endCl="\033[0m\e[0m"
redCl="\e[0;31m\033[1m"
blueCl="\e[0;34m\033[1m"
yellowCl="\e[0;33m\033[1m"
purpleCl="\e[0;35m\033[1m"
turquoiseCl="\e[0;36m\033[1m"
grayCl="\e[0;37m\033[1m"

function menu(){

  echo -e "${grayCl}Que deseas hacer con smb${endCl}\n"
  echo -e "${grayCl}1) Ejecucion de comandos sin credenciales${endCl}"
  echo -e "${grayCl}2) Ejecucion de comandos con credenciales${endCL}"
  echo -e "${grayCl}exit)${endCl}"

}

function no_credentials(){

  local ip_victim
  local disk_option
  local yay_nay
  local command_remote

  read -p "$(echo -e "${grayCl}Ingresa la IP victima: ${endCl}" )" ip_victim

  smbclient -L ////$ip_victim// -N

  read -p "$(echo -e "\n${grayCl}Disco que deseas seleccionar: ${endCl}")" disk_option

  function question_bucle(){

  read -p "$(echo -e "\n${grayCl}Deseas ejecutar remotamente comandos yay/nay: ${endCl}")" yay_nay

  if [ $yay_nay == "yay" ];  then
    
  clear

    while true; do

      read -p "$( echo -e "${grayCl}Comando remoto --> ${endCl}")" command_remote

      echo

      if [ $command_remote == "exit" ]; then

        main

      else

        smbclient //$ip_victim/$disk_option -N -c "${command_remote}"

      fi
  
        echo 

    done

  elif [ $yay_nay == "nay" ]; then 

    clear
    smbclient --no-pass //$ip_victim/$disk_option

  else
    
    clear
    echo -e "${redCl}[!] Opcion no valida${endCl}"
    sleep 1
    clear
    question_bucle

  fi

  }

  question_bucle

}

function with_credentials(){

  local ip_victim
  local user_victim
  local password
  local disk_option
  local yay_nay
  local command_remote

  read -p "$(echo -e "${grayCl}Ip o dominio: ${endCl}\n")" ip_victim

  read -p "$(echo -e "${grayCl}Usuario: ${endCl}\n")" user_victim

  read -p "$(echo -e "${grayCl}Contraseña: ${endCl}\n")" password

  smbclient -L ${ip_victim} --user ${user_victim} --password ${password}

  read -p "$(echo -e "\n${grayCl}Disco que deseas seleccionar: ${endCl}")" disk_option

  function question_bucle(){

  read -p "$(echo -e "\n${grayCl}Deseas ejecutar remotamente comandos yay/nay: ${endCl}")" yay_nay

  if [ $yay_nay == "yay" ];  then
    
  clear

    while true; do

      read -p "$( echo -e "${grayCl}Comando remoto --> ${endCl}")" command_remote

      echo

      if [ $command_remote == "exit" ]; then

        main

      else

        smbclient //${ip_victim}/${disk_option} --user ${user_victim} --password ${password} -c "${command_remote}"
  
      fi
  
        echo 

    done

  elif [ $yay_nay == "nay" ]; then 

    clear
    smbclient //${ip_victim}/${disk_option} --user ${user_victim} --password ${password}

  else
    
    clear
    echo -e "${redCl}[!] Opcion no valida${endCl}"
    sleep 1
    clear
    question_bucle

  fi

  }

  question_bucle

}

function main(){

  while true; do
  
  clear
  menu
  read -p "$( echo -e "\n${redCl}Opcion deseada: ${endCl}")" option

  case "$option" in 

  1)

    clear
    no_credentials

  ;;
  
  2)

    clear
    with_credentials

  ;;

  exit)

    clear
    exit 1

  ;;

  *)
    
    clear
    echo -e "${redCl}[!] Opcion no valida${endCl}"
    sleep 2

  ;;

  esac
  done

}

main

