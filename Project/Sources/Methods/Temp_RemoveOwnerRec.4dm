//%attributes = {"invisible":true}
//Executed on the current selection of Activity log table
//Used to allow users to re-download the Act Log records.
RELATE MANY SELECTION:C340([Owners of Data:62]RefID:1)
C_LONGINT:C283($vlOwnRecs)
C_TEXT:C284($vsUName)  // Command Replaced was o_C_STRING length was 128
$vsUName:=Request:C163("User name to be removed?")
QUERY SELECTION:C341([Owners of Data:62]; [Owners of Data:62]Owner Name:2=$vsUName)
$vlOwnRecs:=Records in selection:C76([Owners of Data:62])
CONFIRM:C162("Delete "+String:C10($vlOwnRecs)+" records in [Owners of Data]?")
If (OK=1)
	DELETE SELECTION:C66([Owners of Data:62])
	//FLUSH CACHE
End if 