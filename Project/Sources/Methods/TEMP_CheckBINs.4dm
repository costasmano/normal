//%attributes = {"invisible":true}
//GP TEMP_CheckBINs

//This procedure is used to compare the current inventory of BINs
//with a list of BINs in a data file (presumably from an earlier version
//of the database).

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
CREATE SET:C116([Bridge MHD NBIS:1]; "Remaining BINs")
$i:=0
$j:=0
RECEIVE PACKET:C104($dImportFile; $BIN; <>sCR)
While (OK=1)
	$i:=$i+1  //Count the records read from the file.
	
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$BIN)
	If (Records in selection:C76([Bridge MHD NBIS:1])=0)
		$text:=$BIN+<>sTab+"Could not find BIN in Database."+<>sCR
		SEND PACKET:C103($dImportRpt; $text)
		$j:=$j+1  //Count the BINs not found.
	Else 
		If (Records in selection:C76([Bridge MHD NBIS:1])>1)
			$text:=$BIN+<>sTab+"Error - More than one matching BIN?"+<>sCR
			SEND PACKET:C103($dImportRpt; $text)
		End if 
		CREATE SET:C116([Bridge MHD NBIS:1]; "Exclude BINs")
		DIFFERENCE:C122("Remaining BINs"; "Exclude BINs"; "Remaining BINs")
	End if 
	
	RECEIVE PACKET:C104($dImportFile; $BIN; <>sCR)
End while 
CLEAR SET:C117("Exclude BINs")

USE SET:C118("Remaining BINs")
$NoBINs:=Records in set:C195("Remaining BINs")
If ($NoBINs>0)
	$text:=<>sCR
	SEND PACKET:C103($dImportRpt; $text)
	ORDER BY:C49([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1)
	For ($k; 1; $NoBINs)
		$text:=[Bridge MHD NBIS:1]BIN:3+<>sTab+[Bridge MHD NBIS:1]BDEPT:1+<>sTab+"BIN not listed in File."+<>sCR
		SEND PACKET:C103($dImportRpt; $text)
		NEXT RECORD:C51([Bridge MHD NBIS:1])
	End for 
End if 
CLEAR SET:C117("Remaining BINs")

$text:=(2*<>sCR)+"BIN Comparison Completed."+<>sCR
$text:=$text+String:C10($i)+" records read from file."+<>sCR
$text:=$text+String:C10($j)+" BINs in file, not found in database."+<>sCR
$text:=$text+String:C10($NoBINs)+" BINs in database, not found in file."+<>sCR
SEND PACKET:C103($dImportRpt; $text)
CLOSE DOCUMENT:C267($dImportRpt)
CLOSE DOCUMENT:C267($dImportFile)