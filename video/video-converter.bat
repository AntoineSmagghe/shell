@echo off
chcp 65001
echo ************************************************************
echo *                                                          *
echo *  Bienvenue dans l'utilitaire de découpe video Proximum   *
echo *                   version 2.0.2                          *
echo *                                                          *
echo ************************************************************
echo *  
echo *  Cliquez sur [1;92m"Entrer"[0m à chaque étapes pour valider vos choix.
echo *  A tout moment tapez [91mctrl+c[0m pour sortir du programme.
echo *  
echo *  Que souhaitez vous faire ? 
echo *  
echo *  [1;94m1. Convertir une vidéo[0m
echo *  [1;94m2. Couper et convertir une vidéo[0m
echo *  
set /p choice=*  Taper le numéro qui correspond à votre choix (1 ou 2), puis tapez sur "Entrer" : 
cscript //nologo src/match.js "^[12]$" "%choice%"
IF errorlevel 1 GOTO :parametresError

echo *  
echo *  Bonne conversion!
echo *  
echo ************************************************************

echo *
set /p "inputFile=* Glissez et deposez la video a traiter ici, puis tapez sur 'Entrer' : "
IF "%inputFile%"=="" GOTO :parametresError
set outputFile=%inputFile:~0,-5%-convert.mp4

echo * 
echo * La vidéo à traiter sera [94m%inputFile%[0m
echo *
echo ************************************************************
IF "%choice%"=="1" GOTO :simpleConversion

echo *
set /p start=* Inscrire le début de la vidéo au format HH:MM:SS, puis tapez sur "Entrer" : 
echo * 
echo * La vidéo commencera à [94m%start%[0m
echo * 
echo ************************************************************
echo *
set /p end=* Inscrire la fin de la vidéo au format HH:MM:SS, puis tapez sur "Entrer" : 
echo * 
echo * La vidéo terminera à [94m%end%[0m
echo *
echo ************************************************************

IF "%start%"=="" IF "%end%"=="" GOTO :simpleConversion
IF "%start%"=="" GOTO :parametresError
IF "%end%"=="" GOTO :parametresError

set startTime=%time%
ffmpeg.exe -t %end% -i %inputFile% -ss %start% -vcodec libx264 -acodec copy -preset ultrafast -filter:v fps=fps=25 -b:v 1000k %outputFile%
set endTime=%time%
GOTO :aurevoirVideo

:simpleConversion
set startTime=%time%
ffmpeg.exe -i %inputFile% -vcodec libx264 -acodec copy -preset ultrafast -filter:v fps=fps=25 -b:v 1000k %outputFile%
set endTime=%time%
GOTO :aurevoirVideo

:parametresError
echo *
echo *  [91mErreur: veuillez entrer de nouveau les commandes pour convertir[0m
echo *  [91mou couper une vidéo.[0m
GOTO :aurevoir

:aurevoirVideo
echo * 
echo *  La vidéo convertie se trouve ici : [94m%outputFile%[0m

:aurevoir
echo *
echo *  Au revoir !
echo * 
pause
EXIT