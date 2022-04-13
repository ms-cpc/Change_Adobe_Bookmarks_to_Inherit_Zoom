@echo off
cls
:: Change_Bookmarks_to_Inheret_Zoom
:: ######################################################
:: VERSION 0.1.130523
:: SCRIPT: CB2IZ
:: CREATION DATE: 2013-05-23
:: LAST MODIFIED: 2013-05-23
:: AUTHOR: Mark SOUTHBY
:: EMAIL: mark@southby.ca
:: ######################################################
:: DESCRIPTION: Simple batch to automate drag and drop application for changing bookmarks in a PDF
:: ######################################################
title CB2IZ
echo Change Bookmarks to Inherit Zoom (easy batch!)...
echo.
set path1=0
set exnum=0
::Check for jpdfbookmarks
:jpichk
IF EXIST jpdfbookmarks.jar goto begin
echo jPDFbookmarkks NOT FOUND. PLEASE PLACE THIS BATCH IN YOUR jPDFbookmarks FOLDER
pause
goto exit

:begin
IF EXIST cb2iztemp.pdf del cb2iztemp.pdf
IF EXIST tempbookmarks.txt del tempbookmarks.txt
IF EXIST temp2.txt del temp2.txt
::grab path1 and file name. Click
set /p path1=Click and drag your PDF file here: 
set /p exnum=New File name:
if %exnum% == 0 goto blank
set exnum=%exnum%.pdf
copy %path1% cb2iztemp.pdf
goto go4it

:blank
color e4
cls
echo FILE NEEDS A NEW NAME!
pause
goto begin


:go4it
if %path1%==0 go to blank
echo Running CB2IZ
::Export
echo Exporting bookmarks...
java -jar jpdfbookmarks.jar -d cb2iztemp.pdf > tempbookmarks.txt
::Replace text
echo replacing text
start /min iz.cmd
::exit
::temp change
::notepad temp2.txt
::echo change bookmarks then
::pause
::Import
echo Importing bookmarks
java -jar jpdfbookmarks.jar -a temp2.txt cb2iztemp.pdf -o %exnum%
::complete, launch PDF
echo Task complete. To launch revised PDF
pause
%exnum%
IF EXIST cb2iztemp.pdf del cb2iztemp.pdf
IF EXIST tempbookmarks.txt del tempbookmarks.txt
IF EXIST temp2.txt del temp2.txt
::exit

::NFAR CH
::ms-53384