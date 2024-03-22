//%attributes = {"invisible":true}
//GP TEMP_ChkSelList

//This procedure verifies the Select List.

C_TEXT:C284($text; $path; $file)
C_TEXT:C284($BIN; $BKey; $AASHTO)
C_LONGINT:C283($i; $j; $recs)
C_TEXT:C284($text)
C_BOOLEAN:C305($PrintWarn)

$text:="In the following dialog box, select the tab-delimited "
$text:=$text+"text file containing the Select List."+(2*<>sCR)
$text:=$text+"Each record should consist of a BIN, a Bridge Key, and an AASHTO rating."
ALERT:C41($text)
C_TIME:C306($dImportFile; $dUpdateRpt; vdUpdateRpt)
$dImportFile:=Open document:C264(""; "TEXT")
If (OK=0)
	//I think it aborts before this, so this is unnecessary.
	ABORT:C156
End if 
vdImpFile:=$dImportFile
$path:=GetPath
$text:="Select List Verification Report"+<>sCR
$text:=$text+Document+(2*<>sCR)
$file:=$path+"Select List Verification Report"
$dUpdateRpt:=Create document:C266($file)
vdUpdateRpt:=$dUpdateRpt
SEND PACKET:C103($dUpdateRpt; $text)

//TRACE

ALL RECORDS:C47([Bridge MHD NBIS:1])
ARRAY TEXT:C222($aBIN; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY BOOLEAN:C223($aXSelect; 0)
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $aBIN; [Bridge MHD NBIS:1]FHWA Select:4; $aXSelect)

$i:=0
RECEIVE PACKET:C104($dImportFile; $BIN; <>sTab)
While (OK=1)
	$i:=$i+1
	RECEIVE PACKET:C104($dImportFile; $BKey; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $AASHTO; <>sCR)
	
	$j:=Find in array:C230($aBIN; $BIN)
	
	$text:=""
	$PrintWarn:=False:C215
	If ($j>0)
		If (Not:C34($aXSelect{$j}))
			$text:=$text+<>sTab+"*** Not updated properly."
			$PrintWarn:=True:C214
		End if 
	Else 
		$text:=$text+<>sTab+"***  Bad BIN!? ***"
		$PrintWarn:=True:C214
	End if 
	If ($PrintWarn)
		$text:=String:C10($i)+<>sTab+$BIN+<>sTab+$BKey+$text+<>sCR
		SEND PACKET:C103($dUpdateRpt; $text)
	End if 
	
	RECEIVE PACKET:C104($dImportFile; $BIN; <>sTab)
End while 
$recs:=$i

$text:=(2*<>sCR)+"Select List Verification Completed."+<>sCR
$text:=$text+String:C10($recs)+" records."+<>sCR
SEND PACKET:C103($dUpdateRpt; $text)
CLOSE DOCUMENT:C267($dUpdateRpt)
CLOSE DOCUMENT:C267($dImportFile)