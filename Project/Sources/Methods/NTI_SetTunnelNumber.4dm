//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/10/15, 11:48:29
//----------------------------------------------------
//Method: NTI_SetTunnelNumber
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_11  //Add new method of assigning Tunnel number
	//Modified by: administrator (11/10/15 16:45:30
	Mods_2018_02  //Allow for change of tunnel number to allow for T or B as first character of second position
	//Modified by: Chuck Miller (2/20/18 17:14:30)
	Mods_2018_05  //Set entry on new TIN input to Allow prefix of T or B
	//Modified by: Chuck Miller (5/10/18 15:48:15)
End if 
[NTI_TunnelInfo:181]NTI_i1_s:6:=""


Case of 
	: (NTI_Prefix_txt="")
	: (Not:C34(NTI_Prefix_txt="T")) & (Not:C34(NTI_Prefix_txt="B"))
	: (NTI_TownCode_s="")
	: (NTI_Number_s="")
	: (Num:C11(NTI_Number_s)<1) | (Num:C11(NTI_Number_s)>99)
	: (NTI_Vent_s="")
	: (Length:C16(NTI_Vent_s)#3)
		
	: (NTI_Owner_s="")
	: (NTI_TunnelID_s="")
	: (Length:C16(NTI_TunnelID_s)#3)
		
	Else 
		[NTI_TunnelInfo:181]NTI_i1_s:6:=NTI_TownCode_s+NTI_Prefix_txt+NTI_Number_s+NTI_TunnelID_s+NTI_Owner_s+NTI_Vent_s
End case 
//End NTI_SetTunnelNumber

