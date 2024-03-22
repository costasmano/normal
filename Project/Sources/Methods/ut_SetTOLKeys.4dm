//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/09/11, 14:57:58
//----------------------------------------------------
//Method: ut_SetTOLKeys
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Ugrade to v11
	//Modified by: Charles Miller (9/9/11 14:58:02)
End if 
READ ONLY:C145(*)
READ WRITE:C146([TableOfLists:125])

ALL RECORDS:C47([TableOfLists:125])
C_LONGINT:C283($Loop_l)

For ($Loop_l; 1; Records in selection:C76([TableOfLists:125]))
	If ([TableOfLists:125]ListKeyID_L:4=0)
		Inc_Sequence("[TableOfLists]"; ->[TableOfLists:125]ListKeyID_L:4)
		SAVE RECORD:C53([TableOfLists:125])
	End if 
	NEXT RECORD:C51([TableOfLists:125])
End for 
//End ut_SetTOLKeys

