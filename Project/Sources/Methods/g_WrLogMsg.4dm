//%attributes = {"invisible":true}
//g_WrLogMsg
//Write a message to a log file, time stamp w date and time.
//Add a CR at end of message
//Will open the error file and then close it.

C_TEXT:C284($1; $errFileName)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284($2; $msg; $msgHdr)
C_TIME:C306($ErrFileID)
C_BOOLEAN:C305($vbLocked; $vbVis)
C_DATE:C307($vdCreate; $vdMod)
C_TIME:C306($vtCreate; $vtMod)
$vbLocked:=False:C215
$errFileName:=$1
$msg:=$2
If ($errFileName#"")
	While (Semaphore:C143("$G_WriteLogMsg"))
		DELAY PROCESS:C323(Current process:C322; 1)
	End while 
	
	$msghdr:=String:C10(Current date:C33(*))+"-"+String:C10(Current time:C178(*))+" <ms:"+String:C10(Milliseconds:C459)+"><t:"+String:C10(Tickcount:C458)+"> : "
	If (Test path name:C476($errFileName)#Is a document:K24:1)
		//document does not exist - create it    
		$ErrFileID:=Create document:C266($errFileName)
		//_ O _SET DOCUMENT CREATOR($errFileName;"R*ch")  //BBEdit creator
	Else 
		C_LONGINT:C283($viNumtries)  //Command Replaced was o_C_INTEGER
		$viNumtries:=0
		Repeat 
			GET DOCUMENT PROPERTIES:C477($errFileName; $vbLocked; $vbVis; $vdCreate; $vtCreate; $vdMod; $vtMod)
			If ($vbLocked)
				G_TickDelay(30)
				$viNumtries:=$viNumtries+1
			End if 
		Until (Not:C34($vbLocked) | ($viNumtries>20))
		If (Not:C34($vbLocked))
			$ErrFileID:=Append document:C265($errFileName)
		End if 
	End if 
	GET DOCUMENT PROPERTIES:C477($errFileName; $vbLocked; $vbVis; $vdCreate; $vtCreate; $vdMod; $vtMod)
	If ((Ok=1) & Not:C34($vbLocked))
		SEND PACKET:C103($ErrFileID; ($msghdr+$msg+Char:C90(13)))
		CLOSE DOCUMENT:C267($ErrFileID)
	End if 
	
	CLEAR SEMAPHORE:C144("$G_WriteLogMsg")
	
End if 