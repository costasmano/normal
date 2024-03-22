
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 04/29/14, 13:17:11
//----------------------------------------------------
//Object Method: [NTI_TunnelInfo];"Input".NTI_TownName_atxt
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 

If (NTI_TownName_atxt>0)
	ARRAY TEXT:C222($Parts_atxt; 0)
	ut_NewTextToArray(NTI_Codes_atxt{NTI_TownName_atxt}; ->$Parts_atxt; "-")
	OBJECT SET ENABLED:C1123(bValidate; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	If (NTI_CheckTownSelection(->NTI_MODTunnelInfo_aB; Num:C11($Parts_atxt{2})))
		[NTI_TunnelInfo:181]NTI_TownName_s:71:=NTI_TownName_atxt{NTI_TownName_atxt}
		
		[NTI_TunnelInfo:181]NTI_i4_L:9:=Num:C11($Parts_atxt{1})  //county code
		[NTI_TunnelInfo:181]NTI_i6_s:11:=$Parts_atxt{2}  //District
		[NTI_TunnelInfo:181]NTI_i5_L:10:=Num:C11($Parts_atxt{3})  //place code
		NTI_TownCode_s:=$Parts_atxt{4}
		NTI_Number_s:=Substring:C12([NTI_TunnelInfo:181]NTI_i1_s:6; 5; 2)
		NTI_TunnelID_s:=Substring:C12([NTI_TunnelInfo:181]NTI_i1_s:6; 7; 3)
		NTI_Owner_s:=Substring:C12([NTI_TunnelInfo:181]NTI_i1_s:6; 10; 3)
		NTI_Vent_s:=Substring:C12([NTI_TunnelInfo:181]NTI_i1_s:6; 13; 3)
		NTI_SetTunnelNumber
		NTI_CheckForValidate
	Else 
		ALERT:C41("You May not Modify for this town")
	End if 
	
End if 