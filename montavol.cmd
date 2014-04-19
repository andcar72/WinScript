:: Monta Volume
:: ---------------------------------
:: a.carrarini@mediaprogetti.it
:: Aprile 2014
:: in %1 c'e' il percorso da montare
:: in %2 c'e' lo user name
:: in %3 c'è la passowrd
:: ---------------------------------
:: Verifica parametri
@ECHO OFF
SETLOCAL
IF "%~1" == "" GOTO NOPAR 
:: parametro %1 senza le virgolette
IF "%2" == "" GOTO NOPAR
IF "%3" == "" GOTO NOPAR

SET percorso=%~1
SET utente=%2
SET password=%3
SET lettera=%4
SET ERR=NESSUNO

::Monta Volome
net use %lettera% "%percorso%" /user:%utente% %password%
IF %errorlevel% GTR 0 SET ERR=NON riesco a trovare il percorso %percorso%
GOTO FINE

:NOPAR
ECHO Manca un parametro essenziale
ECHO uso: montavol.cmd {"network path"} {username} {parssword} [lettera]
SET CODE_ERR=999
GOTO THEEND

:FINE 
:: Non c'e' nessun errore il volume è stato montato, esce
IF %ERR% EQU NESSUNO GOTO THEEND 
:: Errori presenti
::echo blat -subject "Errori in montavol.cmd in %LOGONSERVER%" -body "Errore in %date% %ERR%" -t a.carrarini@mediaprogetti.it -f ass.cds@mediaprogetti.it -server 192.168.2.16 
blat -subject "Errori in montavol.cmd in %LOGONSERVER%" -body "Errore in %date% %ERR%" -t a.carrarini@mediaprogetti.it -f ass.cds@mediaprogetti.it -server 192.168.2.16 
SET CODE_ERR=999
:THEEND
EXIT /B %CODERR%