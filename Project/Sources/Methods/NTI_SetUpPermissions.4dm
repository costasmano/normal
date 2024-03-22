//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/03/15, 13:26:46
//----------------------------------------------------
//Method: NTI_SetUpPermissions
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (11/3/15 13:26:52)
	
	// Modified by: Costas Manousakis-(Designer)-(10/17/17 17:26:34)
	Mods_2017_10
	//  `new way of calculating arrays in NTI_SetUpPermissions using <>aInspRcod
	
End if 
ARRAY BOOLEAN:C223(NTI_ADDTunnelInfo_aB; 0)
ARRAY BOOLEAN:C223(NTI_DELTunnelInfo_aB; 0)
ARRAY BOOLEAN:C223(NTI_MODTunnelInfo_aB; 0)
C_LONGINT:C283($Loop_l)

If (True:C214)
	//TestingHereToo:=False
	//this code will replace the code at the end
	C_LONGINT:C283($size_L)
	$size_L:=Size of array:C274(<>aInspRcod)
	ARRAY BOOLEAN:C223(NTI_ADDTunnelInfo_aB; $size_L+1)
	ARRAY BOOLEAN:C223(NTI_DELTunnelInfo_aB; $size_L+1)
	ARRAY BOOLEAN:C223(NTI_MODTunnelInfo_aB; $size_L+1)
	C_TEXT:C284($suffix_txt)
	
	For ($Loop_l; 1; $size_L)
		$suffix_txt:=NTI_GroupSuffix(<>aInspRcod{$Loop_l})
		NTI_ADDTunnelInfo_aB{$Loop_l}:=(GRP_UserInGroup("NTI_ADDTunnelInfo_"+$suffix_txt)=1)
		NTI_DELTunnelInfo_aB{$Loop_l}:=(GRP_UserInGroup("NTI_DELTunnelInfo_"+$suffix_txt)=1)
		NTI_MODTunnelInfo_aB{$Loop_l}:=(GRP_UserInGroup("NTI_MODTunnelInfo_"+$suffix_txt)=1)
	End for 
	$Loop_l:=$size_L+1
	NTI_ADDTunnelInfo_aB{$Loop_l}:=(GRP_UserInGroup("NTI_ADDTunnelInfo_ALL")=1)
	NTI_DELTunnelInfo_aB{$Loop_l}:=(GRP_UserInGroup("NTI_DELTunnelInfo_ALL")=1)
	NTI_MODTunnelInfo_aB{$Loop_l}:=(GRP_UserInGroup("NTI_MODTunnelInfo_ALL")=1)
	
	//TestingHereToo:=False
Else 
	//START to be replaced
	ARRAY BOOLEAN:C223(NTI_ADDTunnelInfo_aB; 7)
	ARRAY BOOLEAN:C223(NTI_DELTunnelInfo_aB; 7)
	ARRAY BOOLEAN:C223(NTI_MODTunnelInfo_aB; 7)
	
	READ ONLY:C145([PERS_Groups:109])
	READ ONLY:C145([PERS_GroupMembers:110])
	For ($Loop_l; 1; 6)
		NTI_ADDTunnelInfo_aB{$Loop_l}:=(GRP_UserInGroup("NTI_ADDTunnelInfo_D"+String:C10($Loop_L))=1)
		NTI_DELTunnelInfo_aB{$Loop_l}:=(GRP_UserInGroup("NTI_DELTunnelInfo_D"+String:C10($Loop_L))=1)
		NTI_MODTunnelInfo_aB{$Loop_l}:=(GRP_UserInGroup("NTI_MODTunnelInfo_D"+String:C10($Loop_L))=1)
	End for 
	$Loop_l:=7
	NTI_ADDTunnelInfo_aB{$Loop_l}:=(GRP_UserInGroup("NTI_ADDTunnelInfo_ALL")=1)
	NTI_DELTunnelInfo_aB{$Loop_l}:=(GRP_UserInGroup("NTI_DELTunnelInfo_ALL")=1)
	NTI_MODTunnelInfo_aB{$Loop_l}:=(GRP_UserInGroup("NTI_MODTunnelInfo_ALL")=1)
	//END to be replaced
	
End if 

//End NTI_SetUpPermissions