//%attributes = {"invisible":true}
//Method: NTI_AllowAdd_Tin_insp
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/25/16, 11:52:12
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	// Modified by: Costas Manousakis-(Designer)-(10/11/17 14:57:15)
	Mods_2017_10
	//  `use new field [NTI_TunnelInfo]NTI_InspResp - method NTI_GroupSuffix
	
	C_BOOLEAN:C305(NTI_AllowAdd_Tin_insp; $0)
	
End if 
//
C_BOOLEAN:C305($Allow_b)
$Allow_b:=False:C215
C_LONGINT:C283($AllowAddALL_L; $AllowAddDistrict_L)
$AllowAddALL_L:=GRP_UserInGroup("TIN_AddInspections_ALL")

$AllowAddDistrict_L:=GRP_UserInGroup("TIN_AddInspections_"+NTI_GroupSuffix)
Case of 
	: (User in group:C338(Current user:C182; "Design Access Group") | (GRP_UserInGroup("TIN_AddInspections")=1))
		$Allow_b:=True:C214
	: ($AllowAddALL_L=1)
		$Allow_b:=True:C214
	: ($AllowAddDistrict_L=1)
		$Allow_b:=True:C214
End case 

$0:=$Allow_b
//End NTI_AllowAdd