#!/bin/bash

read -p "Indica el teu nom: " nom

saludar() {
    if [ $# -lt 2 ]; then
        echo "Error: Es necessiten 2 parametros"
	return 1
   fi

    echo "Hola, $1, tens $2 edat"
}

saludar "$nom" 23
