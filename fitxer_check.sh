#!/bin/bash

error() {
   echo "ERROR. $1"
   exit 1
}

info() {
   echo "[INFO] $1"
}

info "Script iniciat"
read -p "Digues el fitxer: " fitxer

[ -f "$fitxer" ] || error "$fitxer no existeix"

info "Tot correcte"
