//Method: [NTI_TunnelInfo].Input.TunnelRating_LB
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/01/18, 16:22:58
	// ----------------------------------------------------
	//Created : 
	Mods_2018_05
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		LISTBOX SELECT ROW:C912(*; "TunnelRating_LB"; 0; lk remove from selection:K53:3)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($LBCol_L; $SelectedRow_L)
		
		LISTBOX GET CELL POSITION:C971(*; "TunnelRating_LB"; $LBCol_L; $SelectedRow_L)
		
		If ($SelectedRow_L>0)
			GOTO SELECTED RECORD:C245([NTI_TunnelRatings:189]; $SelectedRow_L)
			LOAD RECORD:C52([NTI_TunnelRatings:189])
			
		End if 
		OBJECT SET VISIBLE:C603(*; "Select"; ($SelectedRow_L>0))
End case 
//End [NTI_TunnelInfo].Input.TunnelRating_LB