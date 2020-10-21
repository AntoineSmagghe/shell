@echo off
echo ***********************************************************
echo *                                                         *
echo *  Bienvenue dans l'utilitaire de decoupe video Proximum  *
echo *                                                         *
echo ***********************************************************

set inputFile=%1
set start=%2
set end=%3
set outputFile=%4

set "x=0" 

FOR %%A IN (%*) DO (
    set /a "x+=1"
    IF "%%A" == "-help" ECHO non !
)

IF %x% GTR 2 (ffmpeg.exe -t %end% -i %inputFile% -ss %start% -vcodec libx264 -acodec copy -preset ultrafast -filter:v fps=fps=25 -b:v 800k %outputFile%)
IF %x% EQU 2 (ffmpeg.exe -i %inputFile% -vcodec libx264 -acodec copy -preset ultrafast -filter:v fps=fps=25 -b 800k %start%)
IF %x% EQU "" (echo Veuillez entrer une commande pour convertir ou couper les vidéos.) ELSE (echo Erreur: pas assez dans les parametres)