If (False:C215)
	//[TIN_Inspections];"ReviewList".bShowSubset 
End if 

LB_Tasks("SHOWSELECTION"; "TunnelInspections")
ORDER BY:C49([TIN_Inspections:184]; [TIN_Inspections:184]NTI_i1_S:1; >)
LB_Tasks("CLEARHEADERS"; "TunnelInspections")
LB_Tasks("DESELECTALL"; "TunnelInspections")
SET WINDOW TITLE:C213("Pending TIN Inspections ["+String:C10(Records in selection:C76([TIN_Inspections:184]))+"]")