#! /bin/bash
MVN="/usr/bin/mvn"

#clear
if [[ ! -f "$MVN" ]] 
then
    echo "The computer hasn't JaCaMo-CLI!"
    echo "Installing dependencies..."
    sleep 3
    sudo apt update
    sudo apt install maven
else
    echo "The computer has Maven"
fi

pkgs=""
# g++ and binutils
which g++ 1> /dev/null 2>&1 
if [[ $? -ne 0 ]]; then
	echo "Adding g++ to installation"
	pkgs="$pkgs g++ binutils"
else
	echo "'g++' already installed"
fi


# make
which make 1> /dev/null 2>&1
if [[ $? -ne 0 ]]; then
	echo "Adding make to installation"
	pkgs="$pkgs make"
else
	echo "'make' already installed"
fi
if [[ "$pkgs" != "" ]]; then
	echo "Installing missing packages"
	sudo apt install -y $pkgs
fi

# Compiling interrupts
echo "Compiling interrupts"
make -C src/interrupts all

echo "Compiling JACAMOb"

HERE=`pwd`
rm -rf JACAMOb.jar
rm -rf target
cd ../../../
mvn clean package
mv target/*-all.jar $HERE/JACAMOb.jar -v
cd $HERE
LD_LIBRARY_PATH="$HERE/src/interrupts" java -jar JACAMOb.jar *.jcm
#echo "Starting the MAS!"
#mvn -f ../../../pom.xml clean compile exec:java \
#  -Dexec.mainClass="jacamo.infra.JaCaMoLauncher" \
#  -Dexec.args="jacamoProject.jcm"
echo "FINISH!"
