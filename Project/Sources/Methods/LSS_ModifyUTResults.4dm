//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/02/15, 11:17:02
//----------------------------------------------------
//Method: LSS_ModifyUTResults
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/2/15 11:17:04)
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
	Mods_2018_08  //Add code to fix problem with UT page on ibput form where uncompoiled ut and ut results data not didplayed correctly
	//Changed list boxes to use named selections ""UT_LB" and "UTResults_LB"
	//Modified by: Chuck Miller (8/30/18 15:35:58)
End if 

C_LONGINT:C283($LBCol_L; LSS_SelectedRow_L)

If (Not:C34(InDoubleClick_B))
	InDoubleClick_B:=True:C214
	
	LISTBOX GET CELL POSITION:C971(*; "UTResults_LB"; $LBCol_L; LSS_SelectedRow_L)
	If (LSS_SelectedRow_L>0)
		GOTO SELECTED RECORD:C245([LSS_UtResult:176]; LSS_SelectedRow_L)
		
		
		LSS_ControlModification(->[LSS_UtResult:176]; "Input")
		InDoubleClick_B:=False:C215
		LSS_SelectUTResults_New
		
		
	Else 
		InDoubleClick_B:=False:C215
	End if 
End if 

//End LSS_ModifyUTResults

