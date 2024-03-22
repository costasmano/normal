//Method: Form Method: [NTI_TunnelInfo];"ListBoxOutput"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 10/29/15, 16:19:20
	//----------------------------------------------------
	Mods_2015_10  // 
	//Modified by: administrator (10/29/15 16:19:21)
	// Modified by: Costas Manousakis-(Designer)-(5/4/16 16:30:41)
	Mods_2016_NTE
	//  `Enabled On Click event on the List Box
	// Modified by: Costas Manousakis-(Designer)-(9/1/16 13:13:57)
	Mods_2016_09
	//  `call NTI_LoadDOMTrees
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
End if 
Case of 
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
		
	: (Form event code:C388=On Load:K2:1)
		InDoubleClick_B:=False:C215
		WIN_SetWindowTitle(->[NTI_TunnelInfo:181])
		NTI_CanAdd_B:=NTI_SetUpCanAdd
		OBJECT SET VISIBLE:C603(*; "bAdd"; NTI_CanAdd_B)
		NTI_LoadDOMTrees
		
	: (Form event code:C388=On Double Clicked:K2:5)
		If (False:C215)  //This code alsao exists in listbox object we do not need or want it in both places
			
			TRACE:C157
			C_LONGINT:C283($LBCol_L)
			LISTBOX GET CELL POSITION:C971(*; "SelectListBox"; $LBCol_L; NTI_TunnelRow_L)
			If (LSS_InventoryRow_L>0)
				ut_SetReadWrite("write"; ->[NTI_TunnelInfo:181])
				GOTO SELECTED RECORD:C245([NTI_TunnelInfo:181]; NTI_TunnelRow_L)
				CREATE SET:C116([NTI_TunnelInfo:181]; "NTI_Set")
				C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob)
				GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
				OBJECT GET COORDINATES:C663(*; "SelectListBox"; $ol; $ot; $or; $ob)
				NTI_ControlModification(->[NTI_TunnelInfo:181]; "Input")
				
				
				SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
				OBJECT GET COORDINATES:C663(*; "SelectListBox"; $wl; $wt; $wr; $wb)
				
				OBJECT MOVE:C664(*; "SelectListBox"; 0; 0; $or-$wr; $ob-$wb)
				
				If (In transaction:C397)  //we must have cancelled out of [NTI_TunnelInfo] input form
					CANCEL TRANSACTION:C241
				End if 
				
				LISTBOX SELECT ROW:C912(*; "SelectListBox"; NTI_TunnelRow_L)
				OBJECT SET SCROLL POSITION:C906(*; "SelectListBox"; NTI_TunnelRow_L)
				ut_SetReadWrite("read"; ->[NTI_TunnelInfo:181])
				
				WIN_SetWindowTitle(->[NTI_TunnelInfo:181])
				
			End if 
		End if 
	: (Form event code:C388=On Unload:K2:2)
		
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
		
End case 
//End Form Method: [NTI_TunnelInfo];"ListBoxOutput"

