//%attributes = {"invisible":true}
//Method: NTI_ListTIN_Inspections
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/25/16, 12:28:29
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
End if 
//
//SET QUERY DESTINATION(Into current selection)
READ ONLY:C145([TIN_Inspections:184])
QUERY:C277([TIN_Inspections:184]; [TIN_Inspections:184]NTI_i1_S:1=[NTI_TunnelInfo:181]NTI_i1_s:6)
ORDER BY:C49([TIN_Inspections:184]; [TIN_Inspections:184]InspDate:3; <; [TIN_Inspections:184]InspectionID:2; <)
UNLOAD RECORD:C212([TIN_Inspections:184])
//End NTI_ListTIN_Inspections