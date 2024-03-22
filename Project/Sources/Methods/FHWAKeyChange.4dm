//%attributes = {"invisible":true}
//proccedure: FHWAKeyChange
//created by: Albert Leung
//date: 6/10/97
//purpose: problems with BIN number
//This is a DOS file so expect CRLF at the end of every record.

C_TIME:C306($dImportFile)
C_TIME:C306($dkeyChange)
C_TEXT:C284($BIN)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($brkey)  // Command Replaced was o_C_STRING length was 12
C_TEXT:C284($Item5)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($StateCode)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($dateChange)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284($reason)  // Command Replaced was o_C_STRING length was 25
C_TEXT:C284($tbuff)
C_TEXT:C284($nbuff)

$StateCode:="251"
$tbuff:=String:C10(Current date:C33(*); 4)
$tbuff:=Delete string:C232($tbuff; 3; 1)  //mm/dd/yy -> mmdd/yy
$dateChange:=Delete string:C232($tbuff; 5; 1)  //mmdd/yy -> mmddyy
$reason:="USING NEW REF SYSTEM"
While (Length:C16($reason)<25)
	$reason:=$reason+" "
End while 

$dImportFile:=Open document:C264("")
If (Ok=1)
	$dkeyChange:=Create document:C266("KEYCHNGE.DAT"; "TEXT")
	If (Ok=1)
		SHORT_MESSAGE("Importing...")
		Repeat 
			RECEIVE PACKET:C104($dImportFile; $tbuff; <>sCR)
			RECEIVE PACKET:C104($dImportFile; $nbuff; 1)  //ignore the line feed character
			
			$BIN:=Substring:C12($tbuff; 4; 3)
			$brkey:=Substring:C12($tbuff; 7; 12)
			$Item5:=Substring:C12($tbuff; 19; 1)
			
			$tbuff:=$StateCode+$BIN+$brkey+$Item5+"   "+$StateCode+"   "+$brkey+$Item5+"   "+$dateChange+"   "+$reason+"  "+<>sCR+<>sLF
			If (Length:C16($tbuff)#82)
				CLOSE WINDOW:C154
				ALERT:C41("Incorrect string length!")
				CLOSE DOCUMENT:C267($dkeyChange)
				CLOSE DOCUMENT:C267($dImportFile)
				ABORT:C156
			End if 
			
			SEND PACKET:C103($dkeyChange; $tbuff)
		Until (Ok=0)
		CLOSE WINDOW:C154
		CLOSE DOCUMENT:C267($dkeyChange)
	End if 
	CLOSE DOCUMENT:C267($dImportFile)
End if 