#!/bin/bash

while true; do
    opcio=$(zenity --list \
        --title="Menú Principal" \
        --column="Opció" --column="Descripció" \
        1 "Saluda a l'usuari segons l'hora" \
        2 "Mostra data i hora formatat" \
        3 "Mostra informació del sistema (CPU/RAM/DISC)" \
        4 "Comprova si existeix un fitxer" \
        5 "Crea una carpeta si no existeix" \
        6 "Calculadora simple (+ - * /)" \
        0 "Sortir" \
        --height=400 --width=500)

    if [ $? -ne 0 ]; then
        exit 0
    fi

    case $opcio in
        1)
            hora=$(date +%H)
            if [ "$hora" -le 12 ]; then
                missatge="Bon dia, $(whoami)"
            elif [ "$hora" -le 18 ]; then
                missatge="Bona tarda, $(whoami)"
            else
                missatge="Bona nit, $(whoami)"
            fi
            zenity --info --title="Salutació" --text="$missatge"
            ;;
        2)
            data=$(date '+%d/%m/%Y %H:%M:%S')
            zenity --info --title="Data i Hora" --text="Data i hora actual:\n$data"
            ;;
        3)
            info=$(echo -e "Disc:\n$(df -h)\n\nMemòria:\n$(free -h)")
            zenity --text-info --title="Informació del sistema" --width=700 --height=400 --filename=<(echo "$info")
            ;;
        4)
            nomArxiu=$(zenity --entry --title="Comprovar arxiu" --text="Escriu el nom de l'arxiu:")
            if [ -f "$nomArxiu" ]; then
                zenity --info --text="L'arxiu $nomArxiu existeix"
            else
                zenity --warning --text="L'arxiu $nomArxiu no existeix"
            fi
            ;;
        5)
            nomDirectori=$(zenity --entry --title="Crear directori" --text="Escriu el nom del directori:")
            if [ -d "$nomDirectori" ]; then
                zenity --info --text="El directori $nomDirectori ja existeix"
            else
                mkdir -p "$nomDirectori"
                zenity --info --text="Directori $nomDirectori creat correctament"
            fi
            ;;
        6)
            num1=$(zenity --entry --title="Calculadora" --text="Primer número:")
            num2=$(zenity --entry --title="Calculadora" --text="Segon número:")
            op=$(zenity --list --title="Selecciona operació" --column="Operació" "+" "-" "*" "/")
            
            case $op in
                +) resultat=$((num1 + num2)) ;;
                -) resultat=$((num1 - num2)) ;;
                \*) resultat=$((num1 * num2)) ;;
                /) 
                    if [ "$num2" -eq 0 ]; then
                        zenity --error --text="Error: divisió entre zero!"
                        continue
                    else
                        resultat=$((num1 / num2))
                    fi
                    ;;
                *) zenity --error --text="Operació no vàlida"; continue ;;
            esac
            zenity --info --title="Resultat" --text="El resultat és: $resultat"
            ;;
        0)
            zenity --info --text="Sortint..."
            exit 0
            ;;
        *)
            zenity --error --text="Opció no vàlida"
            ;;
    esac
done
