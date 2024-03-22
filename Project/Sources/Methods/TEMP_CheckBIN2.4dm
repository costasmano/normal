//%attributes = {"invisible":true}
//GP TEMP_CheckBIN2

//This procedure is used to compare the current inventory of BINs
//with a list of BINs in a data file (presumably from an earlier version
//of the database).

//This version uses arrays instead of sets.

C_TEXT:C284($text; $file; $BIN; $path)
C_LONGINT:C283($NoBINs; $i; $j; $k)  //Command Replaced was o_C_INTEGER


$text:="In the following dialog box, select the text file "
$text:=$text+"containing the list of BINs to be compared."
ALERT:C41($text)
C_TIME:C306($dImportFile; $dImportRpt)
$dImportFile:=Open document:C264(""; "TEXT")
If (OK=0)
	ABORT:C156
End if 
$path:=GetPath

TRACE:C157

$file:=$path+"BIN Comparison Report"
$dImportRpt:=Create document:C266($file)
$text:="BIN Comparison Report"+(2*<>sCR)
SEND PACKET:C103($dImportRpt; $text)

ALL RECORDS:C47([Bridge MHD NBIS:1])
ORDER BY:C49([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3)
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; aBINs)
$i:=0
$j:=0
RECEIVE PACKET:C104($dImportFile; $BIN; <>sCR)
While (OK=1)
	$i:=$i+1  //Count the records read from the file.
	
	$k:=Find in array:C230(aBINs; $BIN)
	If ($k<1)
		$text:=$BIN+<>sTab+"Could not find BIN in Database."+<>sCR
		SEND PACKET:C103($dImportRpt; $text)
		$j:=$j+1  //Count the BINs not found.
	Else 
		DELETE FROM ARRAY:C228(aBINs; $k)
	End if 
	
	RECEIVE PACKET:C104($dImportFile; $BIN; <>sCR)
End while 

$NoBINs:=Size of array:C274(aBINs)
If ($NoBINs>0)
	$text:=<>sCR
	SEND PACKET:C103($dImportRpt; $text)
	For ($k; 1; $NoBINs)
		$text:=aBINs{$k}+<>sTab+"BIN not listed in File."+<>sCR
		SEND PACKET:C103($dImportRpt; $text)
		NEXT RECORD:C51([Bridge MHD NBIS:1])
	End for 
End if 

$text:=(2*<>sCR)+"BIN Comparison Completed."+<>sCR
$text:=$text+String:C10($i)+" records read from file."+<>sCR
$text:=$text+String:C10($j)+" BINs in file, not found in database."+<>sCR
$text:=$text+String:C10($NoBINs)+" BINs in database, not found in file."+<>sCR
SEND PACKET:C103($dImportRpt; $text)
CLOSE DOCUMENT:C267($dImportRpt)
CLOSE DOCUMENT:C267($dImportFile)