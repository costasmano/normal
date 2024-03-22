//%attributes = {"invisible":true}
// Method: ut_ClearFileIDRes
// Description
// Clear the FileIDRes table. 
// This would indicate that the IDs of all local records are
// the same as the IDs on the remote server.
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/23/07, 15:13:45
	// ----------------------------------------------------
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM05a
	// Modified by: Costas Manousakis-(Designer)-(2/3/21 17:17:31)
	Mods_2021_02
	//  `Added message at the end of deletion
End if 
CONFIRM:C162("Clear [FileIDRes Table] for all tables or a single table?"; "ALL"; "Single")
If (OK=1)
	ALL RECORDS:C47([FileIDRes Table:60])
Else 
	C_LONGINT:C283($TableNum_L)
	$TableNum_L:=ut_SelectTableNum
	If ($TableNum_L>0)
		QUERY:C277([FileIDRes Table:60]; [FileIDRes Table:60]File Number:1=$TableNum_L)
	Else 
		REDUCE SELECTION:C351([FileIDRes Table:60]; 0)
	End if 
	
End if 
C_LONGINT:C283($TotalNumRecs_L)
$TotalNumRecs_L:=Records in selection:C76([FileIDRes Table:60])
If ($TotalNumRecs_L>0)
	CONFIRM:C162("Delete "+String:C10($TotalNumRecs_L)+" records from the FileIDRes Table?"; "Delete"; "No")
	If (OK=1)
		SHORT_MESSAGE("Deleting...")
		DELETE SELECTION:C66([FileIDRes Table:60])
		//FLUSH CACHE
		CLOSE WINDOW:C154
		C_LONGINT:C283($RecsLeft_L)
		$RecsLeft_L:=Records in table:C83([FileIDRes Table:60])
		ALERT:C41("Deleted "+String:C10($TotalNumRecs_L; "###,###,###,###,###")+" records from the FileIDRes table\rThere are "+\
			String:C10($RecsLeft_L; "###,###,###,###,###")+" records left.")
	End if 
	
Else 
	ALERT:C41("No Records to be deleted!")
End if 

