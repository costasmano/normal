//%attributes = {"invisible":true}
//GP IMP_Pontis_Insp
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.
//Prompt the user for a folder of Pontis Inspection Reports and import them.

C_TEXT:C284($text; $path; $file)
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
C_DATE:C307($dStart; $dFinish)
C_TIME:C306($tStart; $tFinish; $tElapsed)
C_REAL:C285($rRate)
C_TIME:C306($dImportFile; $dImportRpt)
//TRACE

$text:="In the following dialog box, go to the folder containing Pontis Inspection "
$text:=$text+"Reports (IMPORTANT:  English Units Only!).  Select one file and hit Open.  "
$text:=$text+"All sequentially numbered files (File nnnn) in that folder will be processed."
$text:=$text+" Note: Pontis files must contain Bridge Key values!!!"
ALERT:C41($text)

$dImportFile:=Open document:C264(""; "TEXT")
If (OK=0)
	ABORT:C156
End if 
$path:=GetPath
CLOSE DOCUMENT:C267($dImportFile)

$dStart:=Current date:C33(*)
$tStart:=Current time:C178(*)

$i:=1
$file:=$path+"Import Report"
$dImportRpt:=Create document:C266($file)
$text:="BMS Import Report"+<>sCR
$text:=$text+"Starting to process files in folder '"+Substring:C12($path; 1; Length:C16($path)-1)+"'"+<>sCR
$text:=$text+String:C10($dStart)+"   "+String:C10($tStart)+<>sCR+<>sCR
SEND PACKET:C103($dImportRpt; $text)

$file:=$path+"File "+String:C10($i; "0000")
ON ERR CALL:C155("IMP_Error")
$dImportFile:=Open document:C264($file)
ON ERR CALL:C155("")

While (OK=1)
	IMP_One_File($dImportFile; $dImportRpt)
	CLOSE DOCUMENT:C267($dImportFile)
	
	$i:=$i+1
	$file:=$path+"File "+String:C10($i; "0000")
	ON ERR CALL:C155("IMP_Error")
	$dImportFile:=Open document:C264($file)
	ON ERR CALL:C155("")
End while 

$dFinish:=Current date:C33(*)
$tFinish:=Current time:C178(*)
$tElapsed:=($dFinish-$dStart)*Time:C179("24:00:00")+$tFinish-$tStart
If ($i>1)
	$rRate:=$tElapsed/($i-1)
End if 

$text:=(2*<>sCR)+"BMS Import Completed."+<>sCR
If ($i#2)
	$text:=$text+String:C10($i-1)+" files"
Else 
	$text:=$text+"One file"
End if 
$text:=$text+" processed in folder '"+Substring:C12($path; 1; Length:C16($path)-1)+"'"+<>sCR
$text:=$text+String:C10($dFinish)+"   "+String:C10($tFinish)+<>sCR
$text:=$text+"Elapsed Time "+String:C10($tElapsed)+"   "+String:C10($rRate; "#,##0.000")+" seconds/bridge"+<>sCR
SEND PACKET:C103($dImportRpt; $text)
CLOSE DOCUMENT:C267($dImportRpt)