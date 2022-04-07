ECHO OFF
set DIR_IN=E:\Import\Giornaliera\POD\UPS
set DIR_COPY=E:\Import\Giornaliera\POD\UPS\Backup
set DIR_MOVE=E:\Import\Giornaliera\POD\UPS\DaImportare
set DIR_LOG=E:\Import\Giornaliera\POD\UPS\Log
set ESTENSIONI=.zip
set data=%date%
set ora=%time%
set LOG=%data:~6,4%_%data:~3,2%_%data:~0,2%
set NOMELOG=%DIR_LOG%\%LOG%.log
echo NOMELOG=%NOMELOG%

echo [%date% %time%] Inizio............. >> %NOMELOG%
echo [%date% %time%] Ciclo per estensioni %ESTENSIONI% >> %NOMELOG%

for %%e in (%ESTENSIONI%) do (
	echo [%date% %time%] Verifico presenza file di estensione %%e >> %NOMELOG%
	for /F %%f in ('DIR /B %DIR_IN%\*%%e') do (
		
		echo [%date% %time%] salvo il nome del file prima di unzipparlo %%f >> %NOMELOG%
		
		mkdir E:\Import\Giornaliera\POD\UPS\temp%%~nf
		
			echo [%date% %time%] Sposto e decomprimo il file %DIR_IN%\%%f in %DIR_MOVE%\%%f >> %NOMELOG%
			"E:\ARXIVAR\PodDHL_unzip\bin\7Zip\7z.exe" e %DIR_IN%\%%f -oE:\Import\Giornaliera\POD\UPS\temp%%~nf -y

			echo [%date% %time%] sposto i file nella cartella DaImportare %transito% in %DIR_MOVE% >>%NOMELOG%
			move E:\Import\Giornaliera\POD\UPS\temp%%~nf\*.* %DIR_MOVE%  >> %NOMELOG%
				
			echo [%date% %time%] Sposto file %DIR_IN%\%%f in %DIR_COPY%\%%f >> %NOMELOG%
			move %DIR_IN%\%%f %DIR_COPY%\%%f >> %NOMELOG%

			
			echo [%date% %time%] Cancello cartella temporanea E:\Import\Giornaliera\POD\UPS\temp%%~nf >> %NOMELOG%
			rd /s /q E:\Import\Giornaliera\POD\UPS\temp%%~nf
	)
)

echo [%date% %time%] Fine............. >> %NOMELOG%

ECHO ON


:FINE