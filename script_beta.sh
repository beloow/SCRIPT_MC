#!/bin/bash

# -------------------------------------------------
# PARTIE A EDITER :
# -------------------------------------------------
SCREEN="mc"  # nom utilisé pour le screen
NAME="minecraft"  # nom du serveur, uniquement pour l'affichage des messages
COMMAND="java -jar -Xincgc -Xmx6G server.jar"  # commande de lancement du serveur
DOWNLOAD="wget https://piston-data.mojang.com/v1/objects/c9df48efed58511cdd0213c56b9013a7b5c9ac1f/server.jar"  # commande de telechargement du serveur

# Cette ligne peut-être supprimée si le serveur 
# et le script sont dans le même dossier :
# cd /home/minecraft/mc_adventure/ # emplacement du serveur  
# ------------------------------------------------

running(){
 if ! screen -list | grep -q "$SCREEN"
 then
  return 1
 else
  return 0
 fi
}

case "$1" in
 start)
  if ( running )
  then
echo "Server [$NAME] is already running"
  else
echo "Starting server [$NAME]"
   screen -dmS $SCREEN $COMMAND
  fi
  ;;
 status)
    if ( running )
    then
echo "Running"
    else
echo "Not running"
    fi
  ;;
 screen)
   screen -r $SCREEN
 ;;
 reload)
   screen -S $SCREEN -p 0 -X stuff `printf "reload\r"`
 ;;
 stop)
  if ( running )
  then
screen -S $SCREEN -p 0 -X stuff `printf "stop\r"`
   echo "Stopping server [$NAME]"
  else
echo "Server [$NAME] is not running"
  fi
 ;;
*)

 echo "Usage : {start|stop|status|screen|reload}"
 exit 1
 ;;
esac

exit 0
