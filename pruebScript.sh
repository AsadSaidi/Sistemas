#!/bin/bash

arxiu = "script.sh"

if [ -f "$arxiu"]; then 
   echo "El fitxer $arxiu existeix"
else
   echo "El fitxer $arxiu no existeix"
fi
