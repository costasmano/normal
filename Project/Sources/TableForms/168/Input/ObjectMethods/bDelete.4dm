
//----------------------------------------------------
//User name (OS): Bridge Section
//Date and time: 04/09/15, 16:22:07
//----------------------------------------------------
//Method: Object Method: [LSS_refRouteDirection].Input.bDelete
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: Bridge Section (4/9/15 16:22:14)
	
End if 

LogDeletion(->[LSS_refRouteDirection:168]LSS_RouteDirectionId_s:1; ->[LSS_refRouteDirection:168]LSS_RouteDirectionId_s:1; ->[LSS_refRouteDirection:168]LSS_RouteDirectionId_s:1; 0)
DELETE RECORD:C58([LSS_refRouteDirection:168])
VALIDATE TRANSACTION:C240
CANCEL:C270


//End Object Method: [LSS_refRouteDirection].Input.bDelete

