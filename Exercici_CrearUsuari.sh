#!/bin/bash

read -p "Escriu el nom de l'usuari que vols crear: " user

read -p "Escriu la ruta del fitxer: " fitxer

sudo useradd -m $user

sudo chown -R $user:$user $fitxer