//%attributes = {"invisible":true}
// ----------------------------------------------------
// LST_SetUpForArchive
// User name (OS): charlesmiller
// Date and time: 09/16/11, 12:50:15
// ----------------------------------------------------
// Description
//  ` Create Activity Log records for the Table of Lists
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_09  // CJ Miller`09/16/11, 12:50:17      
	// Modified by: Costas Manousakis-(Designer)-(6/20/14 18:07:51)
	Mods_2014_06_bug
	//  `Added  SAVE RECORD In the =New Record case
	//  `removed the case of 4D version - not needed anymore 
	//  `moved the Flush and save and validate trans at end.
End if 
If (Type:C295(ptr_Changes)#Array 2D:K8:24)
	ARRAY POINTER:C280(ptr_Changes; 0; 0)
End if 
InitChangeStack(1)
If (Record number:C243([TableOfLists:125])=New record:K29:1)
	LogNewRecord(->[TableOfLists:125]ListKeyID_L:4; ->[TableOfLists:125]ListKeyID_L:4; ->[TableOfLists:125]ListKeyID_L:4; 0; "TableOfLists")
	PushChange(1; ->[TableOfLists:125]ListName_s:1)
	PushChange(1; ->[TableOfLists:125]ListSequence_l:3)
	PushChange(1; ->[TableOfLists:125]ListValue_s:2)
	
Else 
	If (Old:C35([TableOfLists:125]ListSequence_l:3)#[TableOfLists:125]ListSequence_l:3)
		PushChange(1; ->[TableOfLists:125]ListSequence_l:3)
	End if 
	If (Old:C35([TableOfLists:125]ListValue_s:2)#[TableOfLists:125]ListValue_s:2)
		PushChange(1; ->[TableOfLists:125]ListValue_s:2)
	End if 
	
End if 
FlushGrpChgs(1; ->[TableOfLists:125]ListKeyID_L:4; ->[TableOfLists:125]ListKeyID_L:4; ->[TableOfLists:125]ListKeyID_L:4; 0)
SAVE RECORD:C53([TableOfLists:125])
VALIDATE TRANSACTION:C240

//End LST_SetUpForArchive