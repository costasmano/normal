//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Administrator
	// Date and time: 06/30/11, 15:24:39
	// ----------------------------------------------------
	// Method: ut_SetInspModDateForPontis
	// Description
	//  ` Set the [Inspections]DateModified date to today, to force the update of
	//  ` CondUnits for these inspections. Then can execute ut_UpdatePontis.
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_06
End if 

LOAD SET:C185([Bridge MHD NBIS:1]; "TempBinSet"; "")
USE SET:C118("TempBinSet")
ORDER BY:C49([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3)
READ ONLY:C145(*)
SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
FIRST RECORD:C50([Bridge MHD NBIS:1])
While (Not:C34(End selection:C36([Bridge MHD NBIS:1])))
	QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=[Bridge MHD NBIS:1]BIN:3)
	QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspReviewed:12=BMS Approved; *)
	QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]InspApproved:167=BMS Approved)
	QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6="RT@"; *)
	QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="CUL")
	ORDER BY:C49([Inspections:27]; [Inspections:27]Insp Date:78; <)
	If (ut_LoadRecordInteractive(->[Inspections:27]))
		[Inspections:27]DateModified:137:=Current date:C33(*)
		SAVE RECORD:C53([Inspections:27])
	End if 
	
	NEXT RECORD:C51([Bridge MHD NBIS:1])
End while 
ALERT:C41("Updated "+String:C10(Records in selection:C76([Bridge MHD NBIS:1])))
CLEAR SET:C117("TempBinSet")