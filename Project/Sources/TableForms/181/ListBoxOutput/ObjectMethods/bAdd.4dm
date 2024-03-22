
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 10/22/15, 12:03:37
//----------------------------------------------------
//Method: Object Method: [NTI_TunnelInfo].ListBoxOutput.bAdd
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (10/22/15 12:03:39)
	// Modified by: Costas Manousakis-(Designer)-(6/14/18 17:12:50)
	Mods_2018_06
	//  `added order by and copy named selection
End if 
START TRANSACTION:C239
ARRAY LONGINT:C221(NTI_SelectedRN_aL; 0)
LONGINT ARRAY FROM SELECTION:C647([NTI_TunnelInfo:181]; NTI_SelectedRN_aL)
FORM SET INPUT:C55([NTI_TunnelInfo:181]; "New_TIN")

C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob)
GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
OBJECT GET COORDINATES:C663(*; "SelectListBox"; $ol; $ot; $or; $ob)

ADD RECORD:C56([NTI_TunnelInfo:181])
SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
OBJECT GET COORDINATES:C663(*; "Inventory_LB"; $wl; $wt; $wr; $wb)

OBJECT MOVE:C664(*; "Inventory_LB"; 0; 0; $or-$wr; $ob-$wb)

If (OK=1)
	//Add to list
	
	CREATE SELECTION FROM ARRAY:C640([NTI_TunnelInfo:181]; NTI_SelectedRN_aL)
	REDRAW:C174(NTI_Tunnel_LB)
	COPY NAMED SELECTION:C331([NTI_TunnelInfo:181]; "NTI_TunnelInfoSet")
	
Else 
	If (In transaction:C397)
		CANCEL TRANSACTION:C241
	End if 
End if 
CLOSE WINDOW:C154
WIN_SetWindowTitle(->[NTI_TunnelInfo:181])

ORDER BY FORMULA:C300([NTI_TunnelInfo:181]; NTI_SortByFormula(1); >)
COPY NAMED SELECTION:C331([NTI_TunnelInfo:181]; "NTI_TunnelInfoSet")

//End Object Method: [NTI_TunnelInfo].ListBoxOutput.bAdd

