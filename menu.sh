#!/bin/bash

mostrar_menu() {
    echo "1) Mostrar data"
    echo "2) Mostrar l'usuari"
    echo "3) Sortir"
}

mostrar_menu 
read -p "Opció: " opcio

case $opcio in
    1) date ;;
    2) whoami ;;
    3) echo "Sortint" ;;
    *) echo "Opcio incorrecta";;
esac
