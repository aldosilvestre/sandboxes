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

echo -e "${purple}"; read -p "Ingese el puerto a exponer -> " port

echo -e "\n"

if [ -n "$port" ]; then
    echo -e "${red}Se paso el puerto $port para el despligue\n${end}"
else
    echo -e "${red}No se paso ningun puerto para exponer como parametro\n${end}"
fi

sleep 1

function createJustfile ()
{
  echo "Creando .justfile"
  touch .justfile

  echo "build:" >> .justfile 2> /dev/null
  echo "    podman build -t user/sandbox:${imageName} ." >> .justfile 2> /dev/null
  echo "run:" >> .justfile 2> /dev/null
  if [ -z "$1" ]; then
    echo "    podman run -it -v \$PWD/project:/home/archuser/project -p $port:$port --rm user/sandbox:${imageName}" >> .justfile 2> /dev/null
  else
    echo "    podman run -it -v \$PWD/project:/home/archuser/project --rm user/sandbox:${imageName}" >> .justfile 2> /dev/null
  fi

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
chmod -R 777 ./project

echo -e "\n${purple}Creando imagen \n${end}"
if command -v just &> /dev/null; then
    just build
  else
    docker build -t user/sandbox:${imageName} .
fi

echo -e "\n\n${green}Finalizado${end}"
echo -e "\n${purple}Si tiene just instalado, puede correr 'just run', en caso contrario ejecute ${purple}\n"

if [ -n "$port" ]; then
  echo -e "${green}  docker run -it -v "$PWD/project:/home/archuser/project" -p ${port}:${port} --rm user/sandbox:${imageName}"
else
  echo -e "${green}  docker run -it -v "$PWD/project:/home/archuser/project" --rm user/sandbox:${imageName}"
fi

