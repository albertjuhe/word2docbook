@ECHO ON
REM ***************************************************
REM    word - docbook
REM    V.1.0                 
REM ***************************************************
cls
set Code=%1
set origin=.
set Saxon_path=%origin%\saxonhe9-2-1-5j\saxon9he.jar
set tools=%origin%\tools\
set input_process=%origin%\input\
set output_process=%origin%\output\
set tmp=%origin%\tmp\
set xsl=%origin%\xsl\
set xpl=%origin%\xpl\
IF NOT EXIST %input_process%%Code%.docx GOTO ERROR_FILE
IF NOT EXIST %Saxon_path% GOTO ERROR_SAXON

echo Opening document %Code%.doc
%tools%unzip.exe -d %tmp% %input_process%%Code%.docx
echo Transforming document to docbook

java -Xmx1024m -jar ".\calabash\calabash.jar" -i source=%tmp%word\document.xml -p Code=%Code% -p titol=%2 -o result=%output_process%%Code%.xml %xpl%xslt.xlp
PAUSE
copy %tmp%word\media\*.* %output_process%
GOTO FINAL

:ERROR_FILE
echo [ERROR]: Doesn't exists the source file: %input_process%%Code%.docx
echo OUTPUT ERROR.
GOTO THEEND

:ERROR_SAXON
echo [ERROR]: Can't find %Saxon_path%
echo Saxon is necessary.
echo Output not generated.
GOTO THEEND

:FINAL
echo Process OK

:THEEND
pause





