@echo off
echo ************************************************************
echo *                                                          *
echo *  Bienvenue dans l'utilitaire de decoupe video Proximum   *
echo *                   version 2.0.0                          *
echo *                                                          *
echo ************************************************************
echo *  
echo *  Cliquez sur "Entrer" a chaque etapes pour valider vos choix.
echo *  A tout moment tappez ctrl+c pour sortir du programme.
echo *  
echo *  Que souhaitez vous faire ? 
echo *  
echo *  1. Convertir une video
echo *  2. Couper et convertir une video
echo *  
set /p choice=*  Tapper le numero qui correspond a votre choix (1 ou 2), puis tappez sur "Entrer" : 
cscript //nologo src/match.js "^[12]$" "%choice%"
IF errorlevel 1 GOTO :parametresError

echo *  
echo *  Bonne conversion!
echo *  
echo ************************************************************

echo *
set /p "inputFile=* Glissez et deposez la video a traiter ici, puis tappez sur 'Entrer' : "
IF !inputFile!=="" GOTO :parametresError
set outputFile=%inputFile:~0,-5%-convert.mp4"

echo * 
echo * La video a traiter sera %inputFile%
echo *
echo ************************************************************
IF "%choice%"=="1" GOTO :simpleConversion

echo *
set /p start=* Inscrire le debut de la video au format (HH:MM:SS), puis tappez sur "Entrer" : 
echo * 
echo * La video commencera a %start%
echo * 
echo ************************************************************
echo *
set /p end=* Inscrire la fin de la video au format (HH:MM:SS), puis tappez sur "Entrer" : 
echo * 
echo * La video terminera a %end%
echo *
echo ************************************************************

IF "%start%"=="" IF "%end%"=="" GOTO :simpleConversion
IF "%start%"=="" GOTO :parametresError
IF "%end%"=="" GOTO :parametresError

ffmpeg.exe -t %end% -i %inputFile% -ss %start% -vcodec libx264 -acodec copy -preset ultrafast -filter:v fps=fps=25 -b:v 1000k %outputFile%
GOTO :aurevoirVideo

:simpleConversion
ffmpeg.exe -i %inputFile% -vcodec libx264 -acodec copy -preset ultrafast -filter:v fps=fps=25 -b:v 1000k %outputFile%
GOTO :aurevoirVideo

:parametresError
echo *
echo *  Erreur: veuillez entrer de nouveau 
echo *  les commandes pour convertir ou couper une video.
GOTO :aurevoir

:aurevoirVideo
echo * 
echo *  La video convertie se trouve ici : %outputFile%

:aurevoir
echo *
echo *  Au revoir !
echo * 
pause
EXIT