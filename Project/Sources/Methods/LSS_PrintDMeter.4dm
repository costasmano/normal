//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 02/24/15, 11:15:08
//----------------------------------------------------
//Method: LSS_PrintDMeter
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	
	//Modified by: administrator (2/24/15 11:15:09)
	// Modified by: Costas Manousakis-(Designer)-(4/20/16 14:31:08)
	Mods_2016_04_bug
	//  `added call to LSS_SetDefDMeterNotes to make sure we have the  sketch notes as needed
	// Modified by: Costas Manousakis-(Designer)-(5/13/16 15:58:36)
	Mods_2016_05_bug
	//  `sort order for DMeter should be by location
	// Modified by: Costas Manousakis-(Designer)-(5/19/16 13:13:28)
	Mods_2016_05_bug
	//  `ORDER BY([LSS_DMeter];[LSS_DMeter]LSS_DMeterDate_d;>;[LSS_DMeter]LSS_Location_s;>)
	
End if 
C_BOOLEAN:C305($1)
QUERY:C277([LSS_DMeter:161]; [LSS_DMeter:161]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
ORDER BY:C49([LSS_DMeter:161]; [LSS_DMeter:161]LSS_DMeterDate_d:9; >; [LSS_DMeter:161]LSS_Location_s:3; >)
If (Records in selection:C76([LSS_DMeter:161])>0)
	LSS_SetDefDMeterNotes
	
	Print form:C5([LSS_Inspection:164]; "Print_DMeter")
	If (Not:C34($1))
		PAGE BREAK:C6(>)
	End if 
End if 
//End LSS_PrintDMeter