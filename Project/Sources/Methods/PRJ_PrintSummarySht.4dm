//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/18/07, 14:40:30
	// ----------------------------------------------------
	// Method: PRJ_PrintSummarySht
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 11:45:08)
	Mods_2007_CM12_5301
End if 
C_LONGINT:C283($NumSelected_L)
C_BOOLEAN:C305($PrintRecs_b)
$PrintRecs_b:=True:C214
$NumSelected_L:=Records in selection:C76([PRJ_ProjectDetails:115])
If ($NumSelected_L>10)
	CONFIRM:C162("Print the summary page for "+String:C10($NumSelected_L)+" projects?")
	If (OK=1)
	Else 
		$PrintRecs_b:=False:C215
	End if 
	
End if 
If ($PrintRecs_b)
	C_LONGINT:C283($LastScale_l; $LastOrient_l)
	GET PRINT OPTION:C734(Orientation option:K47:2; $LastOrient_l)
	GET PRINT OPTION:C734(Scale option:K47:3; $LastScale_l)
	
	C_BOOLEAN:C305(PRJ_PRINT_RELOADVARS_B)
	PRJ_PRINT_RELOADVARS_B:=True:C214
	FORM SET OUTPUT:C54([PRJ_ProjectDetails:115]; "PRJ_Details.rpt")
	G_PrintOptions(2; ""; 94)
	PRINT SETTINGS:C106
	If (OK=1)
		PRINT SELECTION:C60([PRJ_ProjectDetails:115]; >)
	End if 
	PRJ_PRINT_RELOADVARS_B:=False:C215
	FORM SET OUTPUT:C54([PRJ_ProjectDetails:115]; "ProjectDetails.o")
	G_PrintOptions($LastOrient_l; ""; $LastScale_l)
End if 
