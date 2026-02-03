#!/bin/bash
#1. Saluda a l'usuari concret segons l'hora (Matí, Tarda, Nit)
#2. Mostra data i hora formatat
#3. Mostra informació del sistema (CPU/RAM/DISC)
#4. Comprova si existeix un fitxer
#5. Crea una carpeta, si existeix, no ho fa
#6. Calculadora simple a partir de dos números (+ - * /)
#0. Sortir

mostrar_menu() {
    echo "1. Saluda a l'usuari"
    echo "2. Mostra data i hora formatat"
    echo "3. Mostra informació del sistema (CPU/RAM/DISC)"
    echo "4. Comprova si existeix un fitxer"
    echo "5. Crea una carpeta, si existeix, no ho fa"
    echo "6. Calculadora simple a partir de dos números (+ - * /)"
    echo "0. Sortir"
}

mostrar_menu
read -p "Selecciona una opció: " opcio

case $opcio in
    1) 
        hora=$(date +%H)
        if [ "$hora" -le 12 ]; then
            echo "Bon dia, $(whoami)"
        elif [ "$hora" -le 18 ]; then
            echo "Bona tarda, $(whoami)"
        else
            echo "Bona nit, $(whoami)"
        fi 
        ;;
    2) 
        data=$(date '+%d/%m/%Y %H:%M:%S')
        echo "Data i hora actual: $data"
        ;;
    3) 
        echo -e "Disc:\n$(df -h)\n\nMemòria:\n$(free -h)"
        ;;
    4) 
        read -p "Escriu el nom de l'arxiu que vols buscar: " nomArxiu
        if [ -f "$nomArxiu" ]; then
            echo "L'arxiu $nomArxiu existeix"
        else
            echo "L'arxiu $nomArxiu no existeix"
        fi
        ;;
    5) 
        read -p "Escriu el nom del directori que vols crear: " nomDirectori
        if [ -d "$nomDirectori" ]; then
            echo "El directori $nomDirectori ja existeix"
        else
            echo "El directori $nomDirectori no existeix. Creant..."
            mkdir "$nomDirectori"
            echo "Directori creat"
        fi
        ;;
    6)
        read -p "Donam el primer número: " num1
        read -p "Donam el segon número: " num2
        read -p "Tria l'operació (+ - * /): " opcio
        case $opcio in
            +) resultat=$((num1 + num2)) ;;
            -) resultat=$((num1 - num2)) ;;
            \*) resultat=$((num1 * num2)) ;;
            /) 
                if [ "$num2" -eq 0 ]; then
                    echo "Error: divisió entre zero!"
                    exit 1
                else
                    resultat=$((num1 / num2))
                fi
                ;;
            *) echo "Operació no vàlida"; exit 1 ;;
        esac
        echo "El resultat és: $resultat"
        ;;
    0)
        echo "Sortint..."
        exit 0
        ;;
    *)
        echo "Opció no vàlida"
        ;;
esac
