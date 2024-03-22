
// ----------------------------------------------------
// User name (OS): Administrator
// Date and time: 02/25/16, 13:06:03
// ----------------------------------------------------
// Method: Object Method: [LSS_Inspection].LSS_InspectionLB.Button
// Description
// 
//
// Parameters
// ----------------------------------------------------

CREATE SET:C116([LSS_Inspection:164]; "StartSet")

CONFIRM:C162("Are you sure you wish to delete "+String:C10(Records in set:C195("ListboxSet0"))+" records")

If (OK=1)
	DIFFERENCE:C122("StartSet"; "ListboxSet0"; "StartSet")
	USE SET:C118("ListboxSet0")
	UNLOAD RECORD:C212([LSS_Inspection:164])
	READ WRITE:C146([LSS_Inspection:164])
	Repeat 
		DELETE SELECTION:C66([LSS_Inspection:164])
		If (Records in set:C195("LockedSet")=0)
		Else 
			ALERT:C41("Some records locked")
			USE SET:C118("LockedSet")
		End if 
		
		
		
	Until (Records in set:C195("LockedSet")=0)
	USE SET:C118("StartSet")
	REDRAW:C174(Inventory_LB)  // Command Replaced was o_REDRAW LIST 
	
	
End if 