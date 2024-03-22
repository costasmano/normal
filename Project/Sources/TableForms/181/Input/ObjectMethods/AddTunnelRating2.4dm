//Method: [NTI_TunnelRatings].TunnelRating_LB.AddTunnelRating2
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/01/18, 14:03:57
	// ----------------------------------------------------
	//Created : 
	Mods_2018_05
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		OBJECT SET ENABLED:C1123(*; "AddTunnelRating2"; Not:C34(Read only state:C362([NTI_TunnelInfo:181])))
		
	: (Form event code:C388=On Clicked:K2:4)
		FORM SET INPUT:C55([NTI_TunnelRatings:189]; "Input")
		C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob)
		GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
		OBJECT GET COORDINATES:C663(*; "TunnelRating_LB"; $ol; $ot; $or; $ob)
		InitChangeStack(2)
		ADD RECORD:C56([NTI_TunnelRatings:189]; *)
		If (OK=1)
			QUERY:C277([NTI_TunnelRatings:189]; [NTI_TunnelRatings:189]NTI_i1_s:2=[NTI_TunnelInfo:181]NTI_i1_s:6)
			ORDER BY:C49([NTI_TunnelRatings:189]; [NTI_TunnelRatings:189]Inspection_d:12; <)
		End if 
		SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
		OBJECT GET COORDINATES:C663(*; "TunnelRating_LB"; $wl; $wt; $wr; $wb)
		OBJECT MOVE:C664(*; "TunnelRating_LB"; 0; 0; $or-$wr; $ob-$wb)
		
		C_LONGINT:C283($Width_L; $Height_L)
		
		
End case 

//End [NTI_TunnelRatings].TunnelRating_LB.AddTunnelRating2