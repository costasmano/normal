//%attributes = {"invisible":true}
//ut_Message
//Either print message on window or send to a log file.
//Based on process variablex vbOnScreenMessage and
//vfMessageDocRef.
//Usage:
//ut_Message(Message:text)
If (False:C215)
	
	Mods_2005_CM13
End if 

C_TEXT:C284($1; $vtMessage)
C_TIME:C306(vfMessageDocRef)
C_BOOLEAN:C305(vbOnScreenMessage; vbToFileMessage)

$vtMessage:=$1
If (vbOnScreenMessage)
	MESSAGE:C88($vtMessage)
End if 
If (vbToFileMessage)
	//Check for CR/LF combo at end of message
	C_LONGINT:C283($msgLength_L)
	$msgLength_L:=Length:C16($vtMessage)
	If ($msgLength_L>0)
		If (Substring:C12($vtMessage; $msgLength_L; 1)=<>sCR)
			//if string ends only in CR then for Win Platforms add LF
			If (<>PL_LPlatfrm=3)
				$vtMessage:=$vtMessage+<>sLF
			End if 
			
		End if 
	End if 
	SEND PACKET:C103(vfMessageDocRef; $vtMessage)
End if 