#Compresser et couper des vidéos avec FFMPEG

##Compresser rapidement une video:
ffmpeg -i <input file.ext> -vcodec libx264 -preset ultrafast -filter:v fps=fps=25 -b 800k <output name.ext>

####exemple:
ffmpeg -i input.mkv -vcodec libx264 -preset ultrafast -filter:v fps=fps=25 -b 800k output.mp4

##Compresser et couper une video:
ffmpeg -t <fin (format mm:ss)> -i <input (vidéo.ext)> -ss <début (format mm:ss)> -vcodec libx264 -preset ultrafast -filter:v fps=fps=25 -b 800k <output (vidéo.ext)>

####exemple:
ffmpeg -t 18:00 -i web.mp4 -ss 3:00 -vcodec libx264 -preset ultrafast -filter:v fps=fps=25 -b 800k output.mp4
