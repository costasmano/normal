//%attributes = {"invisible":true}
// ----------------------------------------------------
// utl_SetUpTOLKey
// User name (OS): charlesmiller
// Date and time: 09/21/11, 10:51:24
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_09  // CJ Miller`09/21/11, 10:51:26      
End if 
If (False:C215)
	READ ONLY:C145(*)
	READ WRITE:C146([TableOfLists:125])
	
	QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListKeyID_L:4=0)
	
	C_LONGINT:C283($Loop_l)
	For ($Loop_l; 1; Records in selection:C76([TableOfLists:125]))
		If (ut_LoadRecord(->[TableOfLists:125]; 20))
			Inc_Sequence("TableOfLists"; ->[TableOfLists:125]ListKeyID_L:4)
			SAVE RECORD:C53([TableOfLists:125])
		End if 
		NEXT RECORD:C51([TableOfLists:125])
		
	End for 
	
End if 
//End utl_SetUpTOLKey