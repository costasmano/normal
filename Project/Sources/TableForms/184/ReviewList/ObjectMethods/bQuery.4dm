If (False:C215)
	//Object Method: [TIN_Inspections];"ReviewList".bQuery 
	// Modified by: Costas Manousakis-(Designer)-(2/2/17 17:19:08)
	Mods_2017_02
	//  `restrict QUERY to "TunnelEngineer" only
End if 

If (User in group:C338(Current user:C182; "Design Access Group") | (GRP_UserInGroup("TunnelEngineer")=1))
	LB_Tasks("QUERY"; "TunnelInspections")
Else 
	LB_Tasks("QUERYSELECTION"; "TunnelInspections")
End if 
ORDER BY:C49([TIN_Inspections:184]; [TIN_Inspections:184]NTI_i1_S:1; >)
SET WINDOW TITLE:C213("Pending TIN Inspections ["+String:C10(Records in selection:C76([TIN_Inspections:184]))+"]")
