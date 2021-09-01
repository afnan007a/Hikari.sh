#!/bin/bash

py_env(){
  # Pyenv

if [ -d "temp-folder" ]
then 
    echo -e "HI" 2> /dev/null > /dev/null
else
    mkdir -p temp-folder
fi

if [ -z "$PYTHON_VERSION" ] ; then
    echo -e "==============================="
    echo -e "Python version can be 3.9.1 , custom"
    read -p "Python: " PYTHON_VERSION_SELECT
    echo -e "==============================="
case $PYTHON_VERSION_SELECT in
3.9.1)
  echo -e "==============================="
  echo -e "Python 3.9.1"
  PYTHON_VERSION="3.9.1"
  echo -e "==============================="
;;
custom)
  echo -e "==============================="
  echo -e "Custom python version"
  read -p "Python version: " PYTHON_VERSION
  echo -e "Using python $PYTHON_VERSION"
  echo -e "==============================="
;;
*)
  echo -e "hi" 2> /dev/null > /dev/null
;;
esac
fi

git clone https://github.com/pyenv/pyenv.git ~/.pyenv 2> /dev/null > /dev/null
export PYENV_ROOT="$HOME/.pyenv"
PATH="/home/container/.pyenv/bin:$PATH"
eval "$(pyenv init -)" 2> /dev/null > /dev/null
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv 2> /dev/null > /dev/null
eval "$(pyenv virtualenv-init -)" 2> /dev/null > /dev/null
export TMPDIR="$HOME/temp-folder"
     echo -e "Using Python ${PYTHON_VERSION}"
     pyenv install "${PYTHON_VERSION}" -s
     pyenv global "${PYTHON_VERSION}"
     rm -rf temp-folder/python-build*
     clear
}

software_startup(){

if [ -e "discord.bot" ]
then
    PS3='Select: '
    options=("Start Hikari Server" "Install packages for Hikari" "Install packages from requirements.txt" "Exit")
    select opt in "${options[@]}"
    do
        case $opt in            		
            "Start Hikari Server")
                echo -e "Path to main file:"
                read -p "File: " GENERIC_BOT_FILE
                py_env
                python "${GENERIC_BOT_FILE}"
                exit
				break   
                ;;               		             
            "Install packages for Hikari")
			    echo -e "Package:"
                read -p "Package: " GENERIC_PACKAGE
                py_env
                pyenv exec pip3 install ${GENERIC_PACKAGE} --user
                exit
				break   
                ;;                                                                                     
            "Install packages from requirements.txt")
                py_env
	  	 	    pyenv exec pip3 install -r requirements.txt --user
                exit
				break   
                ;;                                                                                                                                                                                                                    
            "Exit")
                echo -e "You selected $REPLY) $opt"
				echo -e "Exit requested"
				exit
                ;;				
            *) echo -e "invalid option $REPLY";;            
        esac
    done
fi

}  

################################ INSTALL SCRIPTS ################################
discord_bot_install(){
touch discord.bot
}
################################ INSTALL SCRIPTS ################################

startup(){
        

cat << "EOF"
      
      
  oooo         o8o  oooo                            o8o       
  `888         `"'  `888                            `"'       ©2021 davfsa       -     MIT license
   888 .oo.   oooo   888  oooo   .oooo.   oooo d8b oooo       documentation      :     https://hikari-py.github.io/hikari/hikari
   888P"Y88b  `888   888 .8P'   `P  )88b  `888""8P `888       support            :     https://discord.gg/Jx4cNGG
   888   888   888   888888.     .oP"888   888      888       egg base built by  :     exotical cat
   888   888   888   888 `88b.  d8(  888   888      888       egg modified by    :     giyu
  o888o o888o o888o o888o o888o `Y888""8o d888b    o888o      



EOF


}

#Execution
startup
software_startup

if [ "$JAR" = "" ]
then
    echo -e "Please choose the number and press enter or send, and it will download it for you"
    PS3='Select: '
    options=("Hikari" "Exit")
    select opt in "${options[@]}"
    do
        case $opt in        
            "Hikari")
                echo -e "You selected $REPLY) $opt"
                 PS3='Server type: '
    options=("Hikari" "Exit")
    select opt in "${options[@]}"
    do
        case $opt in            		
            "Hikari")
                echo -e "You selected $REPLY) $opt"  
                discord_bot_install
				break  
                ;;                   
            "Exit")
                echo -e "You selected $REPLY) $opt"
				echo -e "Exit requested"
				exit
                ;;				
            *) echo -e "invalid option $REPLY";;            
        esac
    done
				break     
                ;;        			
            *) echo -e "invalid option $REPLY";;            
        esac
    done
	JAR="server.jar"
fi
jar_startup
