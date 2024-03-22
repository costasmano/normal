If (False:C215)
	//SC ZZ9 on layout [BMS Inspections];"Inspections In".
	//Copyright © 1996, Thomas D. Nee, All Rights Reserved.
	
	//Cancel Record.
	//The button has been set to no action; the cancel is performed procedurally.
End if 

C_BOOLEAN:C305($Duplicate)
C_TEXT:C284($Text)  // Command Replaced was o_C_STRING length was 80//Confirm message text.
C_LONGINT:C283($NoElems)  //Number of Elements ([Cond Units] records).

//Revert to saved values.
[BMS Inspections:44]Insp Date:4:=Old:C35([BMS Inspections:44]Insp Date:4)
[BMS Inspections:44]Span Group No:3:=Old:C35([BMS Inspections:44]Span Group No:3)

//Check for duplicate inspection.
$Duplicate:=Check_DupInsp
//A duplicate could be found here only if it was imported or if the user created
//two inspections on the current date, which is the default date.
//A new record is saved right after it is created,
//so a regular cancel would not get rid of it.

If (Not:C34($Duplicate))
	CANCEL:C270
Else 
	//This duplicate inspection should be either deleted or modified.
	$NoElems:=Records in selection:C76([Cond Units:45])
	$Text:="Hit OK to edit date,"
	$Text:=$Text+" Cancel to keep both for now."
	$Text:=$Text+" Please eliminate duplicate."
	CONFIRM:C162($Text)
	If (OK#1)
		CANCEL:C270
	End if 
End if 