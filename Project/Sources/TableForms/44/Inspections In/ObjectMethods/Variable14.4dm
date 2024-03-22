//SC ZZ5 on layout [BMS Inspections];"Inspections In".
//Copyright © 1996, Thomas D. Nee, All Rights Reserved.
//Delete Record

C_TEXT:C284($Text)  //Alert message text.
C_LONGINT:C283($NoElems)  //Number of Elements ([Cond Units] records).

$NoElems:=Records in selection:C76([Cond Units:45])
$Text:="Do you really want to delete this inspection record"
Case of 
	: ($NoElems=0)
		$Text:=$Text+"?"
	: ($NoElems=1)
		$Text:=$Text+" and its element?"
	: ($NoElems>1)
		$Text:=$Text+" and its "+String:C10($NoElems)+" elements?"
End case 
CONFIRM:C162($Text)
If (OK=1)
	//The relation automatically deletes related many records.    
	LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1)
	DELETE RECORD:C58([BMS Inspections:44])
	CANCEL:C270
End if 