//%attributes = {"invisible":true}
//Method: NTI_SetModDeleteAccess
//Description
//
// Parameters
// ----------------------------------------------------
//$1 pointer to modify
//$2 pointer to delete

If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 11/03/15, 14:53:24
	//----------------------------------------------------
	Mods_2015_10  // 
	//Modified by: administrator (11/3/15 14:53:54) 
	// Modified by: Costas Manousakis-(Designer)-(1/31/17 12:31:33)
	Mods_2017_01
	//  `added case for inspection responsibility so that agencies (MPA) can edit tunnel info
	// Modified by: Costas Manousakis-(Designer)-(10/13/17 17:40:30)
	Mods_2017_10
	//  `use only inspResp instead of NTI_i6
	//  // if user can add, they can also modify - deletion is explicitly controlled
End if 
C_POINTER:C301($1; $2)
$1->:=True:C214
$2->:=True:C214

C_TEXT:C284($InspResp_txt)
$InspResp_txt:=NTI_GetInspResp([NTI_TunnelInfo:181]NTI_i1_s:6)
C_LONGINT:C283($InspIndex_L)
$InspIndex_L:=Find in array:C230(<>aInspRcod; $InspResp_txt)
C_BOOLEAN:C305($NTI_ModTunnel_b; $NTI_DelTunnel_b)
$NTI_ModTunnel_b:=False:C215
$NTI_DelTunnel_b:=False:C215
If ($InspIndex_L>0)
	$NTI_ModTunnel_b:=NTI_MODTunnelInfo_aB{$InspIndex_L} | NTI_ADDTunnelInfo_aB{$InspIndex_L}
	$NTI_DelTunnel_b:=NTI_DELTunnelInfo_aB{$InspIndex_L}
End if 
//Set up modify

Case of 
	: (User in group:C338(<>CurrentUser_Name; "Design Access Group"))
		
	: (NTI_MODTunnelInfo_aB{Size of array:C274(NTI_MODTunnelInfo_aB)})  //allow ALL
	: (NTI_ADDTunnelInfo_aB{Size of array:C274(NTI_ADDTunnelInfo_aB)})  //if can ADD ALL then can modify ALL
	: ([NTI_TunnelInfo:181]NTI_CreatedBy_s:2=Current user:C182)
	: ($NTI_ModTunnel_b)
		
	Else 
		$1->:=False:C215
End case 

//Set up delete

Case of 
	: (User in group:C338(<>CurrentUser_Name; "Design Access Group"))
	: (NTI_DELTunnelInfo_aB{Size of array:C274(NTI_DELTunnelInfo_aB)})  //allow ALL
	: ($NTI_DelTunnel_b)
		
	Else 
		$2->:=False:C215
End case 

//End NTI_SetModDeleteAccess