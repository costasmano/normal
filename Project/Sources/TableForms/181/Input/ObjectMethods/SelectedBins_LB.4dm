
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/19/15, 12:39:04
//----------------------------------------------------
//Method: Object Method: [NTI_TunnelInfo].Input.SelectedBins_LB
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_11  // 
	//Modified by: administrator (11/19/15 12:39:05)
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
End if 
If (Form event code:C388=On Double Clicked:K2:5)
	If (Not:C34(InDoubleClick_B))
		InDoubleClick_B:=True:C214
		NTI_RemoveBINfromTunnelTIN
		InDoubleClick_B:=False:C215
	End if 
	
End if 
//End Object Method: [NTI_TunnelInfo].Input.SelectedBins_LB

