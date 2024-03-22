
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 04/29/14, 13:17:11
//----------------------------------------------------
//Method: Object Method: [LSS_Inventory].New_InventoryItem.LSS_Cities_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_11  //Add new method of assigning Tunnel number
	//Modified by: administrator (11/10/15 16:45:30)
	
End if 

If (NTI_TownName_atxt>0)
	
	ARRAY TEXT:C222($Parts_atxt; 0)
	ut_NewTextToArray(NTI_Codes_atxt{NTI_TownName_atxt}; ->$Parts_atxt; "-")
	
	If (NTI_CheckTownSelection(->NTI_ADDTunnelInfo_aB; Num:C11($Parts_atxt{2})))
		
		[NTI_TunnelInfo:181]NTI_TownName_s:71:=NTI_TownName_atxt{NTI_TownName_atxt}
		[NTI_TunnelInfo:181]NTI_i4_L:9:=Num:C11($Parts_atxt{1})  //county code
		[NTI_TunnelInfo:181]NTI_i6_s:11:=$Parts_atxt{2}  //District
		[NTI_TunnelInfo:181]NTI_i5_L:10:=Num:C11($Parts_atxt{3})  //place code
		NTI_TownCode_s:=$Parts_atxt{4}
		NTI_SetTunnelNumber
		NTI_CheckForValidate
		
		GOTO OBJECT:C206(*; "NTI_Number_s")
	Else 
		ALERT:C41("You May not add for this town")
	End if 
End if 

//End Object Method: [LSS_Inventory].New_InventoryItem.LSS_Cities_atxt

