@ECHO OFF
powershell
CHCP 65001 > NUL    
ECHO *                             .:;++=iiiiiiiiii=++;.    =::,,,:::=i));=+'
ECHO *                           ,;+==ii)))))))))))ii==+;,      ,,,:=i))+=:
ECHO *                         ,;+=ii))))))IIIIII))))ii===;.    ,,:=i)=i+
ECHO *                        ;+=ii)))IIIIITIIIIII))))iiii=+,   ,:=));=,
ECHO *                      ,+=i))IIIIIITTTTTITIIIIII)))I)i=+,,:+i)=i+
ECHO *
ECHO *                      [1;92mUtilitaire vidéo - version 2.2.1[0m  
ECHO *
ECHO *            +i)ii::   +)IIITI+:+i)I))TTTTLLTTTTTII))=,
ECHO *          :=;)i=:      ,i++::i))I)ITTTTTTTTTTIIII)=+'
ECHO *        .+ii)i=:      ,,::=i)))iIITTTTTTTTIIIII)=+
ECHO *       ,==)ii=;    ,:::=ii)i)iIIIITIIITIIII))i+:'
ECHO *      +=:))i==   :;=iii)+)=  `:i)))IIIII)ii+'
ECHO * 
@REM TODO : CREER une action pour couper sans convertir une video
@REM TODO : TROUVER une solution pour echapper les caractères spéciaux pour video assembler

@REM Make random string for video

SETLOCAL ENABLEDELAYEDEXPANSION
SET "string=abcdefghijklmnopqrstuvwxyz"
SET "randomID="
FOR /L %%i in (1,1,4) DO CALL :add
GOTO :next
:add
SET /a x=%random% %% 26
SET randomID=%randomID%!string:~%x%,1!
GOTO :eof
:next

ECHO *  
ECHO *  Cliquez sur [1;92m"Entrer"[0m à chaque étapes pour valider vos choix.
ECHO *  A tout moment tapez [91mctrl+c[0m pour sortir du programme.
:choices
ECHO *  
ECHO *  Que souhaitez vous faire ? 
ECHO *  
ECHO *  [1;93m1. Convertir/compresser une vidéo[0m
ECHO *  [1;93m2. Couper et convertir/compresser une vidéo[0m
ECHO *  [1;93m3. Joindre deux vidéos[0m
ECHO *  [1;93m0. Sortir[0m
ECHO *  
SET /p choice=*  Tapez le numéro qui correspond à votre choix (1, 2 ou 3), puis tapez sur [92m"Entrer"[0m : 
cscript //nologo src/match.js "^[1230]$" "%choice%"
IF errorlevel 1 GOTO :parametresError
IF "%choice%"=="3" GOTO :videoassembler
IF "%choice%"=="0" GOTO :aurevoir

ECHO *  
ECHO *  Bonne conversion!
ECHO *  
ECHO ************************************************************

ECHO *
SET /p "inputFile=* Glissez et déposez la vidéo a traiter ici, puis tapez sur [92m'Entrer'[0m : "
IF !inputFile!=="" GOTO :parametresError
SET outputFile=%inputFile:~0,-5%-%randomID%.mp4"

ECHO * 
ECHO * La vidéo à traiter sera [94m%inputFile%[0m
ECHO *
ECHO ************************************************************
IF "%choice%"=="1" GOTO :simpleConversion

ECHO *
SET /p start=* Inscrire le début de la vidéo au format HH:MM:SS, puis tapez sur [92m"Entrer"[0m : 
ECHO * 
ECHO * La vidéo commencera à [94m%start%[0m
ECHO * 
ECHO ************************************************************
ECHO *
SET /p end=* Inscrire la fin de la vidéo au format HH:MM:SS, puis tapez sur [92m"Entrer"[0m : 
ECHO * 
ECHO * La vidéo terminera à [94m%end%[0m
ECHO *
ECHO ************************************************************

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
ECHO *
ECHO *  [91mErreur: veuillez entrer de nouveau les commandes pour convertir[0m
ECHO *  [91mou couper une vidéo.[0m
GOTO :aurevoir

:aurevoirVideo
ECHO * 
ECHO *  L'opération a durée %timeDelay%
ECHO *  La vidéo convertie se trouve ici : [94m%outputFile%[0m
ECHO *  
SET /p playAgain=*  Souhaitez vous effectuer une autre opération ? (oui/non)
IF "%playAgain%"=="oui" GOTO :choices

:aurevoir
ECHO *
ECHO *  Au revoir !
ECHO * 
pause
EXIT

:videoassembler
src/video-assembler.bat
EXIT