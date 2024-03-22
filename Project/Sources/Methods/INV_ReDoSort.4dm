//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/20/06, 14:23:28
	// ----------------------------------------------------
	// Method: INV_ReDoSort
	// Description
	// Re-do sorting on current display list
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM02
End if 
C_BOOLEAN:C305($DoSort_b)
$DoSort_B:=(SortOrder_aL{1}#0)
If ($DoSort_b)
	MULTI SORT ARRAY:C718(SortArrays_aptr; SortOrder_aL)
End if 
CREATE SELECTION FROM ARRAY:C640([InventoryPhotoInsp:112]; InvPhotoInspRecNum_aL)