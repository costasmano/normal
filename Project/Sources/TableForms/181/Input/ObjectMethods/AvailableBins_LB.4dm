
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/19/15, 12:03:27
//----------------------------------------------------
//Method: Object Method: [NTI_TunnelInfo].Input.AvailableBins_LB
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_11  // 
	//Modified by: administrator (11/19/15 12:03:30)
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
End if 
Case of 
		
	: (Form event code:C388=On Double Clicked:K2:5)
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			NTI_AssignBINtoTunnelTIN
			InDoubleClick_B:=False:C215
		End if 
		
	: (Form event code:C388=On Selection Change:K2:29)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(NTI_FontColor_al))
			If (AvailableBins_LB{$loop_L})
				//selected row - make sure font color is readable - leave red or switch to white
				If (NTI_FontColor_al{$loop_L}=0x00FF0000)
					NTI_FontColor_al{$loop_L}:=0x00FF0000  //white?
					
				Else 
					NTI_FontColor_al{$loop_L}:=0x00FFFFFF  //white?
				End if 
			Else 
				If (NTI_FontColor_al{$loop_L}=0x00FF0000)
				Else 
					NTI_FontColor_al{$loop_L}:=0x0000  //black?
				End if 
				
			End if 
			
		End for 
		
End case 


//End Object Method: [NTI_TunnelInfo].Input.AvailableBins_LB

