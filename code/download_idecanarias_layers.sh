#!/usr/bin env bash

# Capa de los espacios naturales protegidos
enp="https://opendata.sitcan.es/upload/medio-ambiente/eennpp.zip"

wget -P data/ -O data/enp.zip $enp ; unzip data/enp.zip -d data/ 
