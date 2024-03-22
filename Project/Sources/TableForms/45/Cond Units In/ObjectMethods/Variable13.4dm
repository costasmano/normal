If (False:C215)
	//SC ZZ9 (Cancel) on layout [Cond Units];"Cond Units In".
	//Copyright © 1996, Thomas D. Nee, All Rights Reserved.
	// Modified by: costasmanousakis-(Designer)-(3/2/2006 16:21:22)
	Mods_2006_CM03
End if 
C_BOOLEAN:C305(vNewCURecord_b)
If (vNewCURecord_b)
	C_TEXT:C284($Text)
	$Text:="Cancelling after creating a new Element!"
	$Text:=$Text+<>sCR+"If you Continue, the new Element will be Deleted!"
	$Text:=$Text+<>sCR+"To Save this Element, hit Stop and then Save!"
	CONFIRM:C162($Text; "Continue"; "Stop")
	If (OK=1)
		LogDeletion(->[BMS Inspections:44]Inspection ID:1; ->[Cond Units:45]Inspection ID:2; ->[Cond Units:45]Cond Unit ID:1; 2)
		DELETE RECORD:C58([Cond Units:45])
		CANCEL:C270
		vCanned:=True:C214
	Else 
		
	End if 
	$Text:=""
Else 
	CANCEL:C270
End if 
vCanned:=True:C214
