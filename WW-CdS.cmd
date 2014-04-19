@ECHO OFF
TITLE COPIA PUBBLICITA' CdS in WOODWING
SETLOCAL
::
:: Script che copia i file .pdf in uscita dal sistema FilePrimer.
:: Il trasporta di FP copia i file in una cartella di temporanea
:: questo script copia i pdf prima nella cartella motivi su IDS server
:: poi copia i .pdf per l'elaborazione da parte di AUTOPILOT
::
:: DIPENDENZE:
:: TOUCH.exe
:: ROBOCOPY.exe
:: BLAT.exe
::
:: V. 1.00 - 29.03.2013 - a.carrarini@mediaprogetti.it
::
::Cartella dove il FP copia i materiali trasportati
SET FP-SOURCE=G:\WW-IN
::Cartella di Autopilot
SET TO-AUTOPILOT=G:\OUT\pdf
::Cartella motivi sistema editoriale WW CdS
::SET MOTIVI=\\192.168.6.129\pubblicita\motivi
SET MOTIVI=\\192.168.6.129\pubblicita

:: Controllo PATH
IF NOT EXIST %MOTIVI% (
ECHO call montavol.cmd "%MOTIVI%" administrator cdscds
IF %errorlevel% EQU 999 GOTO ERRORE
)
::
:: Se non ci sono PDF da copiare esce 
IF NOT EXIST %FP-SOURCE%\*.pdf GOTO FINE 
::
TOUCH %FP-SOURCE%\*.pdf

:: START ROBOCOPY
::
::Copia per IDS\Pubblicita\motivi
ROBOCOPY.exe %FP-SOURCE% %MOTIVI%\motivi /E /R:2 /W:3 /NP /log+:WW-CdS.log
::Copia per AUTOPILOT
ROBOCOPY.exe %FP-SOURCE% %TO-AUTOPILOT% /E /MOV /R:2 /W:3 /NP /log+:WW-CdS.log
::
:: END ROBOCOPY
WAIT 5
GOTO theend
 
:ERRORE
::Mail errore
ECHO %ERR% 
:FINE
CLS
ECHO Non ci sono file pdf in %FP-source%
WAIT 5
:theend
EXIT /b