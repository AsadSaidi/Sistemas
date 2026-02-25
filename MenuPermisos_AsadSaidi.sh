#!/bin/bash

crearPermisosUsuari() {
    user=$(zenity --entry \
        --title="Usuari" \
        --text="Escriu el nom de l'usuari:"
    )

    fitxer=$(zenity --entry \
        --title="Fitxer" \
        --text="Escriu el nom del fitxer:"
    )        

    sudo useradd -m $user
    sudo chown -R $user:$user $fitxer  
    zenity --info --text="L'usuari $user és ara el propietari de $fitxer"     
}

existeixUsuari() {
    user=$(zenity --entry \
        --title="Usuari" \
        --text="Escriu el nom de l'usuari:"
    )
    if grep -q "^$user:" /etc/passwd; then
        sudo chown -R $user:$user "fitxer.txt"
        zenity --info \
            --title="Correcte" \
            --text="El fitxer ha cmabiat a $user"
    else
        zenity --info --text="L'usuari amb el nom $user no existeix"     
    fi        
}

menuPermisos() {

    fitxer2="fitxer2.txt"

    permisos=$(zenity --list \
    --title="Canviar permisos" \
    --text="Selecciona els permisos:" \
    --checklist \
    --column="Selecciona" --column="Permisos" \
    FALSE "Usuari - Lectura (u+r)" \
    FALSE "Usuari - Escriptura (u+w)" \
    FALSE "Usuari - Execució (u+x)" \
    FALSE "Grup - Lectura (g+r)" \
    FALSE "Grup - Escriptura (g+w)" \
    FALSE "Grup - Execució (g+x)" \
    FALSE "Altres - Lectura (o+r)" \
    FALSE "Altres - Escritura (o+w)" \
    FALSE "Altres - Execució (o+x)" \
    --separator=" "
    )

    for permis in $permisos; do
        case $permis in
            *u+r*) chmod u+r "$fitxer2" ;;
            *u+w*) chmod u+w "$fitxer2" ;;
            *u+x*) chmod u+x "$fitxer2" ;;            
            *g+r*) chmod g+r "$fitxer2" ;;                        
            *g+w*) chmod g+w "$fitxer2" ;;
            *g+x*) chmod g+x "$fitxer2" ;;
            *o+r*) chmod o+r "$fitxer2" ;;
            *o+w*) chmod o+w "$fitxer2" ;;
            *o+x*) chmod o+x "$fitxer2" ;; 
        esac
    done   

    zenity --info --text="Els permisos han sigut actualitzats correctament."     
}

buscarPID() {
    proces=$(zenity --entry \
        --title="Buscar el PID:" \
        --text="Introdueix el nom del procès que vulguis:"
    )

    if [[ -z "$proces" ]]; then
        zenity --error --text="No has introduït cap procés."
        return
    fi    

    pids=$(pgrep "$proces")
    if [[ -z "$pids" ]]; then
        zenity --info \
            --title="Resultat:" \
            --text="No s'ha trobat cap procés anomenat $proces"
    else
        zenity --info \
            --title="Resultat:" \
            --text="PID trobats per $proces:\n$pids"
    fi    
}

matarProces() {
    proces=$(zenity --entry \
        --title="Matar procès" \
        --text="Introdueix el nom del programa que vols finalitzar:"
    )

    if [[ -z "$proces" ]]; then
        zenity --error --text="No has introduït cap procés."
        return
    fi

    if pgrep "$proces" > /dev/null; then

        pkill "$proces"

        zenity --info \
            --title="Procés finalitzat:" \
            --text="S'han matat el proces anomenat: $proces"
    else
        zenity --error \
            --title="Error:" \
            --text="No s'ha trobat cap procès anomenat $proces"
    fi        
}

mostrarMenu() {
while true; do
    opcio=$(zenity --list \
    --title="menu" \
    --width=520 --height=320 \
    --column="Opció" --column="Descripció" \
    "1" "Crear un usuario i asignar-li un fitxer nou" \
    "2" "Valida l'existenica d'un usuari i donar-li propietat d'un fitxer" \
    "3" "Canviar els permisos d'un fitxer visualment" \
    "4" "Buscar tots els PID d'un procés" \
    "5" "Matar un proces amb el nom del programa" \
    "0" "Sortir" \
    )
    
    if [ -z "$opcio" ]; then
        exit 0
    fi

    case "$opcio" in
    1) crearPermisosUsuari ;;
    2) existeixUsuari ;;
    3) menuPermisos ;;
    4) buscarPID ;;
    5) matarProces ;;
    0) exit 0 ;;
    esac

done        
}

mostrarMenu