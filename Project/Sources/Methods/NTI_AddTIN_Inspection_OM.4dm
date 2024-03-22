//%attributes = {"invisible":true}
//Method: NTI_AddTIN_Inspection_OM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/04/16, 17:10:20
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(8/9/16 12:51:16)
	Mods_2016_08_bug
	//  `added code to reset window and listbox size
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		//enable/disable this accordingly
		OBJECT SET VISIBLE:C603(Self:C308->; NTI_AllowAdd_Tin_insp)
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob)
		GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
		OBJECT GET COORDINATES:C663(*; "TunnelInspections_LB"; $ol; $ot; $or; $ob)
		NTI_AddTIN_Inspection
		SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
		OBJECT GET COORDINATES:C663(*; "TunnelInspections_LB"; $wl; $wt; $wr; $wb)
		OBJECT MOVE:C664(*; "TunnelInspections_LB"; 0; 0; $or-$wr; $ob-$wb)
		
End case 

//End NTI_AddTIN_Inspection