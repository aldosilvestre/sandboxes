#!/bin/bash

# colors
green="\e[0;32m\033[1m"
red="\e[0;31m\033[1m"
purple="\e[0;35m\033[1m"
end="\033[0m\e[0m"

# variables
pwd=$PWD

echo -e "\n${green} Bienvenido al generador de sandboxes, recuerde tener su 'Dockerfile modificado'.${end}"

echo -e "${purple}"; read -p "Ingese el nombre de la imagen -> " imageName

echo -e "\n"

sleep 1

function createJustfile ()
{
  echo "Creando .justfile"
  touch .justfile

  echo "build:" >> .justfile 2> /dev/null
  echo "    podman build -t user/sandbox:${imageName} ." >> .justfile 2> /dev/null
  echo "run:" >> .justfile 2> /dev/null
  echo "    podman run --network host -it -v \$PWD/project:/home/archuser/project --rm user/sandbox:${imageName}" >> .justfile 2> /dev/null

}

echo -e "\n${purple}Comprobando Just \n${end}"
if command -v just &> /dev/null; then
    rm -rf .justfile
    echo "Just esta instalado"
    createJustfile
  else
    echo "programa no instalado"
fi

echo -e "\n${purple}Configurando proyecto \n${end}"
rm -rf project

echo "Generando carpetas donde se aloja el projecto"
mkdir project | cd

echo "Quitando permisos"
chmod -R 755 project

echo -e "\n${purple}Creando imagen \n${end}"
if command -v just &> /dev/null; then
    just build
  else
    docker build -t user/sandbox:${imageName} .
fi

echo -e "\n\n${green}Finalizado${end}"
echo -e "\n${purple}Si tiene just instalado, puede correr 'just run', en caso contrario ejecute ${purple}\n"

echo -e "${green}  docker run --network host -it -v "$PWD/project:/home/archuser/project" --rm user/sandbox:${imageName}"

