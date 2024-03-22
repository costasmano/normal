// ----------------------------------------------------
// Object Method: GroupDD_as
// User name (OS): cjmiller
// Date and time: 04/15/08, 13:48:38
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2008_v55  //r004 `04/15/08, 13:48:40     
End if 

If (GroupDD_as{GroupDD_as}="Create New Group")  // assign new group
	INSERT IN ARRAY:C227(GroupDD_as; Size of array:C274(GroupDD_as)+1; 1)
	GroupDD_as{Size of array:C274(GroupDD_as)}:="Replacement Group # "+String:C10(Size of array:C274(GroupDD_as)-2)
	GroupDD_as:=Size of array:C274(GroupDD_as)
	
End if 



//End Object Method: GroupDD_as