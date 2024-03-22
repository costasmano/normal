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
	// Modified by: Costas Manousakis-(Designer)-(4/11/19 11:37:52)
	Mods_2019_04_bug
	//  `get the related TunnelRating records on Load
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		QUERY:C277([NTI_TunnelRatings:189]; [NTI_TunnelRatings:189]NTI_i1_s:2=[NTI_TunnelInfo:181]NTI_i1_s:6)
		ORDER BY:C49([NTI_TunnelRatings:189]; [NTI_TunnelRatings:189]RatingReport_d:3; <)
		LISTBOX SELECT ROW:C912(*; "TunnelRating_LB"; 0; lk remove from selection:K53:3)
		
		
	: (Form event code:C388=On Double Clicked:K2:5)
		C_LONGINT:C283($LBCol_L)
		
		LISTBOX GET CELL POSITION:C971(*; "TunnelRating_LB"; $LBCol_L; LSS_SelectedRow_L)
		If (LSS_SelectedRow_L>0)
			ARRAY LONGINT:C221($SelectedRN_aL; 0)
			LONGINT ARRAY FROM SELECTION:C647([NTI_TunnelRatings:189]; $SelectedRN_aL)
			
			GOTO SELECTED RECORD:C245([NTI_TunnelRatings:189]; LSS_SelectedRow_L)
			
			C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob)
			GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
			OBJECT GET COORDINATES:C663(*; "TunnelRating_LB"; $ol; $ot; $or; $ob)
			NTI_CurrentPage_L:=0
			NTI_ControlModification(->[NTI_TunnelRatings:189]; "Input")
			
			QUERY:C277([NTI_TunnelRatings:189]; [NTI_TunnelRatings:189]NTI_i1_s:2=[NTI_TunnelInfo:181]NTI_i1_s:6)
			ORDER BY:C49([NTI_TunnelRatings:189]; [NTI_TunnelRatings:189]Inspection_d:12; <)
			
			SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
			OBJECT GET COORDINATES:C663(*; "TunnelRating_LB"; $wl; $wt; $wr; $wb)
			
			OBJECT MOVE:C664(*; "TunnelRating_LB"; 0; 0; $or-$wr; $ob-$wb)
			REDRAW:C174([NTI_TunnelRatings:189]Inspection_d:12)
			REDRAW:C174([NTI_TunnelRatings:189]RatingReport_d:3)
			REDRAW:C174([NTI_TunnelRatings:189]RatingReportInvertGirder_s:6)
			REDRAW:C174([NTI_TunnelRatings:189]RatingReportInvertSlab_s:5)
			REDRAW:C174([NTI_TunnelRatings:189]RatingReportRoofGirder_s:4)
			
		End if 
		
End case 

//End [NTI_TunnelInfo].Input.TunnelRating_LB