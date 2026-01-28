#!/bin/bash

fitxer="info.txt"
echo "Aqui tens informació de la data d'avui" > $fitxer
echo "" >> $fitxer

date >> $fitxer
