//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/16/05, 15:13:48
	// ----------------------------------------------------
	// Method: CM_SortInvAssgnArr
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
End if 
ARRAY POINTER:C280(CM_TempArrayPtr; 6)
ARRAY LONGINT:C221(CM_TempArrayOrder; 6)
CM_TempArrayPtr{1}:=->CM_InvAssgnINo_aL
CM_TempArrayOrder{1}:=1
CM_TempArrayPtr{2}:=->CM_InvAssgnANo_aI
CM_TempArrayOrder{2}:=1
CM_TempArrayPtr{3}:=->CM_InvAssgnTLF_C_aR
CM_TempArrayOrder{3}:=0
CM_TempArrayPtr{4}:=->CM_InvAssgnTLF_D_aR
CM_TempArrayOrder{4}:=0
CM_TempArrayPtr{5}:=->CM_InvAssgnDE_aR
CM_TempArrayOrder{5}:=0
CM_TempArrayPtr{6}:=->CM_InvAssgnID_aL
CM_TempArrayOrder{6}:=0
MULTI SORT ARRAY:C718(CM_TempArrayPtr; CM_TempArrayOrder)
ARRAY POINTER:C280(CM_TempArrayPtr; 0)  //clear temp arrays
ARRAY LONGINT:C221(CM_TempArrayOrder; 0)
