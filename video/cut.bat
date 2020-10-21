@echo off
color 04
echo ***********************************************************
echo *                                                         *
echo *  Bienvenue dans l'utilitaire de decoupe video Proximum  *
echo *                   version 1.0.0                         *
echo *                                                         *
echo ***********************************************************
echo *
echo * A tout moment tappez ctrl+c pour sortir du programme
echo * 
echo *  Si vous souhaitez juste convertir une video sans la couper,
echo *  Passez les questions de debut et de fin de la video en 
echo *  cliquant sur "Entrer"
echo *  
echo *  Bonne chance!
echo *

set /p inputFile=* Glissez et deposer la video a traiter ici
echo * La video a traiter sera %inputFile%
echo *
echo ************************************************************
echo *
set /p start=* Inscrire le debut de la video au format (HH:MM:SS)
echo * La video commencera a %start%
echo * 
echo ************************************************************
echo *
set /p end=* Inscrire la fin de la video au format (HH:MM:SS)
echo * La video terminera a %end%
echo *
echo ************************************************************

FOR %%A IN (%*%) DO (
    IF "%%A"=="q" EXIT
)

IF "%inputFile%"=="" GOTO :parametresError
set outputFile=%inputFile:~0,-4%-convert.mp4

IF "%start%"=="" IF "%end%"=="" GOTO :simpleConversion
IF "%start%"=="" GOTO :parametresError
IF "%end%"=="" GOTO :parametresError

ffmpeg.exe -t %end% -i %inputFile% -ss %start% -vcodec libx264 -acodec copy -preset ultrafast -filter:v fps=fps=25 -b:v 800k %outputFile%
EXIT

:simpleConversion
ffmpeg.exe -i %inputFile% -vcodec libx264 -acodec copy -preset ultrafast -filter:v fps=fps=25 -b 800k %outputFile%
EXIT

:parametresError
echo *
echo * Erreur: veuillez entrer entrer de nouveau 
echo * les commandes pour convertir ou couper une video.

:aurevoir
echo * 
echo * Au revoir !
echo * 
pause
EXIT