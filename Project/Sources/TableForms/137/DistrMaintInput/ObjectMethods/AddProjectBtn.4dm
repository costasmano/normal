If (False:C215)
	//Object Method: [DCM_WorkOrders];"DistrMaintInput". AddProjectBtn
	
	// Modified by: costasmanousakis-(Designer)-(9/13/10 15:00:42)
	Mods_2010_09
End if 

FORM SET INPUT:C55([DCM_Project:138]; "DistrWorkOrderInput")
ADD RECORD:C56([DCM_Project:138])

RELATE MANY:C262([DCM_WorkOrders:137])
ORDER BY:C49([DCM_Project:138]; [DCM_Project:138]BridgeNo:4; >)
DCM_WO_PrjLB_Control("LOAD")