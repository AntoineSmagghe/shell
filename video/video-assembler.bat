@echo off
chcp 65001 > nul
@REM echo                             ______
@REM echo                            /     /\
@REM echo                           /     /##\
@REM echo                          /     /####\
@REM echo                         /     /######\
@REM echo                        /     /########\
@REM echo                       /     /##########\
@REM echo                      /     /#####/\#####\
@REM echo                     /     /#####/++\#####\
@REM echo                    /     /#####/++++\#####\
@REM echo                   /     /#####/\+++++\#####\
@REM echo                  /     /#####/  \+++++\#####\
@REM echo                 /     /#####/    \+++++\#####\
@REM echo                /     /#####/      \+++++\#####\
@REM echo               /     /#####/        \+++++\#####\
@REM echo              /     /#####/__________\+++++\#####\
@REM echo             /                        \+++++\#####\
@REM echo            /__________________________\+++++\####/
@REM echo            \+++++++++++++++++++++++++++++++++\##/
@REM echo             \+++++++++++++++++++++++++++++++++\/
@REM echo              ``````````````````````````````````
@REM echo *
@REM echo *
echo **************************************************************
echo *                                                            *
echo *  Bienvenue dans l'utilitaire d'assemblage vidéo Proximum   *
echo *                   version 1.0.0                            *
echo *                                                            *
echo **************************************************************
echo *
echo *  [91m! Les vidéos à assembler doivent être du même format et du[0m
echo *  [91mmême encodage. Si vous souhaitez assembler deux vidéos[0m
echo *  [91mde différents formats / encodage, vous devez convertir[0m
echo *  [91mles deux morceaux avec l'outil "vidéo-converter.bat" avant[0m
echo *  [91mde les assembler ![0m
echo *  
echo *  Cliquez sur [92m'Entrer'[0m à chaque étapes pour valider vos choix.
echo *  A tout moment tapez [91mctrl+c[0m pour sortir du programme.
echo *
pause
echo *
set /p "inputFile1=*  Glissez et déposez la première vidéo ici, puis tapez sur [92m'Entrer'[0m : "
IF !inputFile1!=="" GOTO :parametresError

echo * 
echo * La première vidéo est [94m%inputFile1%[0m
echo *
echo ************************************************************

echo *
set /p "inputFile2=*  Glissez et déposez la seconde vidéo ici, puis tapez sur [92m'Entrer'[0m : "
IF !inputFile2!=="" GOTO :parametresError

echo * 
echo * La seconde vidéo est [94m%inputFile2%[0m
echo *
echo ************************************************************
set outputFile=%inputFile1:~0,-5%-join.mp4"

:joinvideo
set startTime=%time%
echo file %inputFile1:\=\\% > assembly.tmp
echo file %inputFile2:\=\\% >> assembly.tmp
ffmpeg.exe -safe 0 -f concat -i assembly.tmp -c copy %outputFile%
del assembly.tmp
set endTime=%time%

:parametresError
echo *
echo *  Erreur: veuillez entrer de nouveau les commandes pour convertir
echo *  ou couper une vidéo.
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