//%attributes = {"invisible":true}
If (User in group:C338(Current user:C182; "Design Access Group"))
	C_TIME:C306(vfMessageDocRef)
	C_TEXT:C284($vsMsgFile; $vtMessage)
	$vsMsgFile:="TestFileFromServer.txt"
	vfMessageDocRef:=Create document:C266($vsMsgFile; "TEXT")
	$vtMessage:="A One line message"+Char:C90(13)
	
	SEND PACKET:C103(vfMessageDocRef; $vtMessage)
	
	CLOSE DOCUMENT:C267(vfMessageDocRef)
	vfMessageDocRef:=Open document:C264($vsMsgFile)
	RECEIVE PACKET:C104(vfMessageDocRef; $vtMessage)
	
	CLOSE DOCUMENT:C267(vfMessageDocRef)
End if 
