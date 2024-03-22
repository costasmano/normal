//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/19/08, 21:06:41
	// ----------------------------------------------------
	// Method: PRJ_SetupBINGroups
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5404  // ("NEWBINS")
End if 
ARRAY TEXT:C222(GroupDD_as; 0)  //Command Replaced was o_ARRAY string length was 25
ARRAY LONGINT:C221($GroupNos_aL; 0)
QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
DISTINCT VALUES:C339([PRJ_ProjectDetailsIncludedBINS:122]PDB_GroupNumber_l:6; $GroupNos_aL)
SORT ARRAY:C229($GroupNos_aL)
C_LONGINT:C283($i)
For ($i; 1; Size of array:C274($GroupNos_aL))
	If ($GroupNos_aL{$i}>0)
		INSERT IN ARRAY:C227(GroupDD_as; (Size of array:C274(GroupDD_as)+1))
		GroupDD_as{Size of array:C274(GroupDD_as)}:="Replacement Group # "+String:C10($GroupNos_aL{$i}; "##0")
	End if 
	
End for 