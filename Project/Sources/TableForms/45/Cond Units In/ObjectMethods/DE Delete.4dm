If (False:C215)
	//SC ZZ5 (Delete) on layout [Cond Units];"Cond Units In".
	//Copyright © 1996, Thomas D. Nee, All Rights Reserved.
	//Delete Record.
	// Modified by: costasmanousakis-(Designer)-(3/2/2006 16:14:49)
	Mods_2006_CM03
End if 
C_TEXT:C284($Text)  //Alert message text.

$Text:="Do you really want to delete this element record?"
CONFIRM:C162($Text)
If (OK=1)
	LogDeletion(->[BMS Inspections:44]Inspection ID:1; ->[Cond Units:45]Inspection ID:2; ->[Cond Units:45]Cond Unit ID:1; 2)
	DELETE RECORD:C58([Cond Units:45])
	CANCEL:C270
End if 
