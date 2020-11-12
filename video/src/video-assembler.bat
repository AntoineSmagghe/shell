@echo off
chcp 65001 > nul
echo *
echo *  [91mLes vidéos à assembler doivent être du même format et du même encodage[0m
echo *  [91mLes caractères spéciaux sont interdits dans les noms et les chemins d'accès[0m
echo *
echo *  [93mSi vous souhaitez assembler deux vidéos de différents[0m
echo *  [93mformats / encodage, vous devez convertir les deux morceaux[0m
echo *  [93mavant de les assembler ![0m
echo *  
echo *
set /p "inputFile1=*  Glissez et déposez la première vidéo ici, puis tapez sur [92m'Entrer'[0m : "
IF !inputFile1!=="" GOTO :parametresError
set inputFile1=%inputFile1:"='%
set inputFile1=%inputFile1:\=\\%
set inputFile1=%inputFile1: =\ %

echo * 
echo *  La première vidéo est [94m%inputFile1%[0m
echo *
echo ************************************************************

echo *
set /p "inputFile2=*  Glissez et déposez la seconde vidéo ici, puis tapez sur [92m'Entrer'[0m : "
IF !inputFile2!=="" GOTO :parametresError
set inputFile2=%inputFile2:"='%
set inputFile2=%inputFile2:\=\\%
set inputFile2=%inputFile2: =\ %

echo * 
echo *  La seconde vidéo est [94m%inputFile2%[0m
echo *
echo ************************************************************
set outputFile=%inputFile1:~0,-5%-join.mp4

:joinvideo
cd src/
echo file %inputFile1% > assembly.tmp
echo file %inputFile2% >> assembly.tmp
echo %outputFile%
ffmpeg.exe -f concat -safe 0 -i assembly.tmp -c copy %outputFile%
del assembly.tmp
GOTO :aurevoirVideo

:parametresError
echo *
echo *  [91mErreur: veuillez entrer de nouveau les commandes pour convertir[0m
echo *  [91mou couper une vidéo.[0m
echo * 
set /p playAgain=*  Souhaitez vous revenir au menu ? (oui/non)
IF "%playAgain%"=="oui" (cd ../ & video-converter.bat)
GOTO :aurevoir

:aurevoirVideo
echo * 
echo *  La vidéo convertie se trouve ici : [94m%outputFile:\\=\%[0m
echo *  
set /p playAgain=*  Souhaitez vous effectuer une autre opération ? (oui/non)
IF "%playAgain%"=="oui" (cd ../ & video-converter.bat)

:aurevoir
echo *
echo *  Au revoir !
echo * 
pause
EXIT