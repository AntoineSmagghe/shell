@echo off
chcp 65001 > nul    
echo *                                                                    ..;===+.
echo *                                                                .:=iiiiii=+=
echo *                                                             .=i))=;::+)i=+,
echo *                                                          ,=i);)I)))I):=i=;
echo *                                                       .=i==))))ii)))I:i++
echo *                                                     +)+))iiiiiiii))I=i+:'
echo *                                .,:;;++++++;:,.       )iii+:::;iii))+i='
echo *                             .:;++=iiiiiiiiii=++;.    =::,,,:::=i));=+'
echo *                           ,;+==ii)))))))))))ii==+;,      ,,,:=i))+=:
echo *                         ,;+=ii))))))IIIIII))))ii===;.    ,,:=i)=i+
echo *                        ;+=ii)))IIIIITIIIIII))))iiii=+,   ,:=));=,
echo *                      ,+=i))IIIIIITTTTTITIIIIII)))I)i=+,,:+i)=i+
echo "        [91m        ____  _________  _  __(_)___ ___  __  ______ ___  [0m
echo "        [91m       / __ \/ ___/ __ \| |/_/ / __ `__ \/ / / / __ `__ \ [0m
echo "        [91m      / /_/ / /  / /_/ />  </ / / / / / / /_/ / / / / / / [0m
echo "        [91m     / .___/_/   \____/_/|_/_/_/ /_/ /_/\__,_/_/ /_/ /_/  [0m
echo "        [91m    /_/                                                  [0m
echo *                      [1;92mUtilitaire vidéo - version 2.1.2[0m  
@REM echo *                      --------------------------------
echo *            +i)ii::   +)IIITI+:+i)I))TTTTLLTTTTTII))=,
echo *          :=;)i=:      ,i++::i))I)ITTTTTTTTTTIIII)=+'
echo *        .+ii)i=:      ,,::=i)))iIITTTTTTTTIIIII)=+
echo *       ,==)ii=;    ,:::=ii)i)iIIIITIIITIIII))i+:'
echo *      +=:))i==   :;=iii)+)=  `:i)))IIIII)ii+'
echo *    .+=:))iiiiiiii)))+ii;
echo *   .+=;))iiiiii)));ii+
echo *  .+=i:)))))))=+ii+
echo * .;==i+::::=)i=;
echo * ,+==iiiiii+,
echo * `+=+++;`
echo * 
@REM TODO : CREER une action pour couper sans convertir une video
@REM TODO : utiliser des techniques pour échapper les espaces sur windows ^ ou encarder par ` 
@REM echo ************************************************************
@REM echo *                                                          *
@REM echo *        Bienvenue dans l'utilitaire video Proximum        *
@REM echo *                   version 2.2.0                          *
@REM echo *                                                          *
@REM echo ************************************************************

@REM Make random string for video

setlocal enabledelayedexpansion
set "string=abcdefghijklmnopqrstuvwxyz"
set "randomID="
for /L %%i in (1,1,4) do call :add
@REM echo %randomID%
goto :next
:add
set /a x=%random% %% 26
set randomID=%randomID%!string:~%x%,1!
goto :eof
:next

echo *  
echo *  Cliquez sur [1;92m"Entrer"[0m à chaque étapes pour valider vos choix.
echo *  A tout moment tapez [91mctrl+c[0m pour sortir du programme.
:choices
echo *  
echo *  Que souhaitez vous faire ? 
echo *  
echo *  [1;93m1. Convertir/compresser une vidéo[0m
echo *  [1;93m2. Couper et convertir/compresser une vidéo[0m
echo *  [1;93m3. Joindre deux vidéos[0m
echo *  [1;93m0. Sortir[0m
echo *  
set /p choice=*  Tapez le numéro qui correspond à votre choix (1, 2 ou 3), puis tapez sur [92m"Entrer"[0m : 
cscript //nologo src/match.js "^[1230]$" "%choice%"
IF errorlevel 1 GOTO :parametresError
IF "%choice%"=="3" GOTO :videoassembler
IF "%choice%"=="0" GOTO :aurevoir

echo *  
echo *  Bonne conversion!
echo *  
echo ************************************************************

echo *
set /p "inputFile=* Glissez et déposez la vidéo a traiter ici, puis tapez sur [92m'Entrer'[0m : "
IF !inputFile!=="" GOTO :parametresError
set outputFile=%inputFile:~0,-5%-%randomID%.mp4"

echo * 
echo * La vidéo à traiter sera [94m%inputFile%[0m
echo *
echo ************************************************************
IF "%choice%"=="1" GOTO :simpleConversion

echo *
set /p start=* Inscrire le début de la vidéo au format HH:MM:SS, puis tapez sur [92m"Entrer"[0m : 
echo * 
echo * La vidéo commencera à [94m%start%[0m
echo * 
echo ************************************************************
echo *
set /p end=* Inscrire la fin de la vidéo au format HH:MM:SS, puis tapez sur [92m"Entrer"[0m : 
echo * 
echo * La vidéo terminera à [94m%end%[0m
echo *
echo ************************************************************

IF "%start%"=="" IF "%end%"=="" GOTO :simpleConversion
IF "%start%"=="" GOTO :parametresError
IF "%end%"=="" GOTO :parametresError

cd src/
ffmpeg.exe -t %end% -i %inputFile% -ss %start% -vcodec libx264 -acodec aac -preset ultrafast -filter:v fps=fps=25 -b:v 1000k %outputFile%
GOTO :aurevoirVideo

:simpleConversion
cd src/
ffmpeg.exe -i %inputFile% -vcodec libx264 -acodec aac -preset ultrafast -filter:v fps=fps=25 -b:v 1000k %outputFile%
GOTO :aurevoirVideo

:parametresError
echo *
echo *  [91mErreur: veuillez entrer de nouveau les commandes pour convertir[0m
echo *  [91mou couper une vidéo.[0m
GOTO :aurevoir

:aurevoirVideo
echo * 
echo *  L'opération a durée %timeDelay%
echo *  La vidéo convertie se trouve ici : [94m%outputFile%[0m
echo *  
set /p playAgain=*  Souhaitez vous effectuer une autre opération ? (oui/non)
IF "%playAgain%"=="oui" GOTO :choices

:aurevoir
echo *
echo *  Au revoir !
echo * 
pause
EXIT

:videoassembler
src/video-assembler.bat
EXIT