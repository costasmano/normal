
// ----------------------------------------------------
// User name (OS): Administrator
// Date and time: 09/30/14, 16:20:19
// ----------------------------------------------------
// Method: Object Method: [NTI_ELEM_DEFS];"ListBox_Output".NTI_Elements_LB
// Description
// 
//

// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2017_12  //Add code to update activity log for [NTI_ELEM_DEFS]
	//Modified by: Chuck Miller (12/14/17 13:05:09)
	Compiler_LB
End if 
C_LONGINT:C283($LBCol_L; LBRow_L)
Case of 
	: (Form event code:C388=On Header Click:K2:40)
		
	: (Form event code:C388=On Display Detail:K2:22)
		
	: (Form event code:C388=On Double Clicked:K2:5)
		
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			
			LISTBOX GET CELL POSITION:C971(*; "NTI_Elements_LB"; $LBCol_L; LBRow_L)
			If (LBRow_L>0) & (LBRow_L<=Records in selection:C76([NTI_ELEM_DEFS:182]))
				COPY NAMED SELECTION:C331([NTI_ELEM_DEFS:182]; "NTI_ELEM_DEFSSet")
				
				GOTO SELECTED RECORD:C245([NTI_ELEM_DEFS:182]; LBRow_L)
				If (ut_LoadRecordInteractiveV2(->[NTI_ELEM_DEFS:182])=1)
					C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob)
					GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
					OBJECT GET COORDINATES:C663(*; "NTI_Elements_LB"; $ol; $ot; $or; $ob)
					FORM SET INPUT:C55([NTI_ELEM_DEFS:182]; "Input")
					MODIFY RECORD:C57([NTI_ELEM_DEFS:182])
					
					InDoubleClick_B:=False:C215
					
					SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
					OBJECT GET COORDINATES:C663(*; "NTI_Elements_LB"; $wl; $wt; $wr; $wb)
					
					OBJECT MOVE:C664(*; "NTI_Elements_LB"; 0; 0; $or-$wr; $ob-$wb)
					
					If (In transaction:C397)  //we must have cancelled out of inventory input form
						CANCEL TRANSACTION:C241
					End if 
					USE NAMED SELECTION:C332("NTI_ELEM_DEFSSet")
					CLEAR NAMED SELECTION:C333("NTI_ELEM_DEFSSet")
					
					LISTBOX SELECT ROW:C912(*; "NTI_Elements_LB"; LBRow_L)
					OBJECT SET SCROLL POSITION:C906(*; "NTI_Elements_LB"; LBRow_L)
					ut_SetReadWrite("read"; ->[NTI_ELEM_DEFS:182])
				End if 
				
				WIN_SetWindowTitle(->[NTI_ELEM_DEFS:182])
				
			Else 
				InDoubleClick_B:=False:C215
			End if 
		End if 
	: (Form event code:C388=On Load:K2:1)
		WIN_SetWindowTitle(->[NTI_ELEM_DEFS:182])
		InDoubleClick_B:=False:C215
End case 
//End Method: Object Method: [NTI_ELEM_DEFS];"ListBox_Output".NTI_Elements_LB
