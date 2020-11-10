#Envoyer des données sur un serveur distant avec curl via sftp ou ftp. (sans problèmes de mdp)
[commande type]
`curl --insecure --user username:password -T /path/to/sourcefile ftp://desthost/path/`

[exemple]
`curl --insecure --user proximum365:fNYYMi3u4Fr5Z -T ~/Desktop/video-converter.zip ftp://proximum365.com/public_html/tools/`


#Créer un zip d'un certain dossier 
[commande type]
`git archive --format=zip --prefix=git-docs/ HEAD:Documentation/ > git-1.4.0-docs.zip`
"Put everything in the current head’s Documentation/ directory into git-1.4.0-docs.zip, with the prefix git-docs/."

[exemple]
`git archive -9 --format=zip -o ~/Desktop/video-converter.zip HEAD:video`