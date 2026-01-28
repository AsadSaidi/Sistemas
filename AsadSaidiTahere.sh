#!/bin/bash

fitxer="info.txt"

mostrar_menu() {
    echo "1) Informacio bàsica del sistema"
    echo "2) Informacio bàsica de disc i memòria"
    echo "3) Informacio completa (tot)"
}

if [ -f "$fitxer" ]; then
   echo "El fitxer ja existeix. S'escriura al final del fitxer"
else
   echo "Creant nou fitxer..."
   nano info.txt
fi

echo "Informe generat el: $(date)" >> "$fitxer"
echo "---------------------------" >> "$fitxer"

mostrar_menu
read -p "Escull una opció: " opcio

case $opcio in
    1) echo -e "Usuari: $(whoami)\nNom de l'equip: $(hostname)\nKernel: $(uname -r)" >> "$fitxer" ;;
    2) echo -e "Disc:\n$(df -h)\nMemòria:\n$(free -h)" >> "$fitxer" ;;
    3) 
        echo -e "Usuari: $(whoami)\nNom de l'equip: $(hostname)\nKernel: $(uname -r)" >> "$fitxer"
        echo -e "Disc:\n$(df -h)\nMemòria:\n$(free -h)" >> "$fitxer"
        ;;
    *) echo "Opció no vàlida. Sortint." ; exit 1 ;;
esac

echo "Fitxer generat correctament."
echo "Informe guardat a $fitxer"