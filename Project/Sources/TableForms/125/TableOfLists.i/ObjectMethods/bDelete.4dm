// ----------------------------------------------------
// Object Method: bDelete
// User name (OS): charlesmiller
// Date and time: 09/16/11, 12:52:13
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_09  // CJ Miller`09/16/11, 12:52:18      ` Type all local variables for v11
	//Create entries in the ACtivity log
End if 
CONFIRM:C162("Are you sure you wish to delete the "+[TableOfLists:125]ListValue_s:2+" record for List "+[TableOfLists:125]ListName_s:1; "Delete"; "Cancel")
C_LONGINT:C283($Version4D_L)
$Version4D_L:=Num:C11(Substring:C12(Application version:C493; 1; 2))

If (OK=1)
	If ($Version4D_L>8)
		LogDeletion(->[TableOfLists:125]ListKeyID_L:4; ->[TableOfLists:125]ListKeyID_L:4; ->[TableOfLists:125]ListKeyID_L:4; 0)
	End if 
	If (Records in set:C195(SelectedListName_s)>0)
		DIFFERENCE:C122(SelectedListName_s; "UserSet"; SelectedListName_s)
	End if 
	DELETE RECORD:C58([TableOfLists:125])
	VALIDATE TRANSACTION:C240
	If (Records in set:C195(SelectedListName_s)>0)
		USE SET:C118(SelectedListName_s)
	Else 
		ALL RECORDS:C47([TableOfLists:125])
	End if 
	CANCEL:C270
End if 

//End Object Method: bDelete