#!/bin/bash

# function
addFolder() {
    # -d pour valider que c'est bien un dossier existant'
    if [ -d $1 ]
        then
            echo "$1 is a folder."
        else
            echo "$1 does not exists. Add it."
            mkdir $1
    fi    
}

addDataFile() {
    # $@ contient la liste des arguments
    echo "addDataFile($@)"
    # -e pour valider que le fichier exist
    if [ -e $1 ]
        then
            echo "$1 file already exist"
        else
            echo -e "Sample data for :\n\t$1" > $1
    fi
}


testFolder="./tst"
dataFolder="$testFolder/data"

clear
pwd

addFolder $testFolder
echo "$dataFolder"
addFolder $dataFolder

for ((i=0; i<5; i++))
do
    echo "$i"
    dataFile="$dataFolder/data0$i.txt"
    addDataFile $dataFile
done

exit $?