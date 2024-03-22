//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/08/07, 12:38:20
	// ----------------------------------------------------
	// Method: PRJ_PrintProjisUpdate
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM12_5301
End if 
C_LONGINT:C283($NumSelected_L)
C_BOOLEAN:C305($PrintRecs_b)
$PrintRecs_b:=True:C214
$NumSelected_L:=Records in selection:C76([PRJ_ProjectDetails:115])
If ($NumSelected_L>50)
	CONFIRM:C162("Print the the Projis Update Form for "+String:C10($NumSelected_L)+" projects?")
	If (OK=1)
	Else 
		$PrintRecs_b:=False:C215
	End if 
	
End if 
If ($PrintRecs_b)
	
	C_TEXT:C284(PRJ_ProjisTotalPgs_s)  // Command Replaced was o_C_STRING length was 10
	PRJ_ProjisTotalPgs_s:=Request:C163("Enter total number of Projis Pages"; PRJ_ProjisTotalPgs_s)
	FORM SET OUTPUT:C54([PRJ_ProjectDetails:115]; "ProjisUpdate")
	G_PrintOptions
	PRINT SETTINGS:C106
	If (OK=1)
		PRINT SELECTION:C60([PRJ_ProjectDetails:115]; *)
	End if 
	FORM SET OUTPUT:C54([PRJ_ProjectDetails:115]; "ProjectDetails.o")
End if 