@Echo off
SETLOCAL
TITLE COPIA PUBBLICITA' TTS in WOODWING
:: *****************************************************
:: Script di copia verso NES TTS PDF di pubblicità
:: *****************************************************
::
:: DIPENDENZE:
:: touch.exe
:: robocopy.exe
:: BLAT.exe
:: WAIT.exe
::
:: V. 0.2 07/11/2006
:: V. 0.3 24/10/2008
:: V. 1.0 27/03/2014
:: Copia vs NES ma prima smista i materiali vs la cartella \\192.168.6.129\Pubblicita\Motivi
:: per il nuovo sistema editoriale Woodwing
:: a.carrarini@mediaprogetti.it
::
:: Cartella "motivi" sistema WW NES
SET WW=\\192.168.135.157\Pubblicita
:: Cartella dove FP deposita i materiali TTS dopo il trasporta
SET FP-source=G:\OPITTS\tuttosport\PDF
:: Cartella a TTS dove autopilot processa i materiali trasportati
SET NES-dest=\\192.168.135.60\Autopilot
:: Copia locale per controllo pubblicità da Media Service
SET CdS-mediaservice= F:\4tts

:: Controllo PATH
IF NOT EXIST %WW% (
call montavol.cmd "%WW%" administrator srvsrv
IF %errorlevel% EQU 999 GOTO ERRORE
)
IF NOT EXIST %NES-dest% (
call montavol.cmd "%NES-dest%" administrator tts
IF %errorlevel% EQU 999 GOTO ERRORE
)

IF NOT EXIST %FP-source%\*.pdf GOTO NOPDF

touch %FP-source%\*.pdf
 
:: START ROBOCOPY
::
::Copia per Media Service
robocopy.exe %FP-source% %CdS-mediaservice% /E /R:2 /W:3 /NP
::Copia per WW in NES su MOTIVI

			::robocopy.exe %FP-source%\*.pdf %WW% /E /R:2 /W:3 /NP /log+:WW-NES.log

:: Copia per server AUTOPILOT di Torino
robocopy.exe %FP-source% %NES-dest%\PDF /E /MOV /R:2 /W:3 /NP /log+:WW-NES.log
::
:: END ROBOCOPY
WAIT 5
GOTO FINE
 
:ERRORE
::Mail errore
Echo %ERR%
GOTO FINE
:NOPDF
CLS
Echo Non ci sono file pdf in %FP-source%
WAIT 5
:FINE
exit /b

