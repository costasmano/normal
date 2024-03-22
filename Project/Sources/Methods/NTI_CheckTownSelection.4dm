//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/17/15, 11:13:47
//----------------------------------------------------
//Method: NTI_CheckTownSelection
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_11  // 
	//Modified by: administrator (11/17/15 11:13:48)
	// Modified by: Costas Manousakis-(Designer)-(10/17/17 17:26:34)
	Mods_2017_10
	//  `new way of calculating arrays in NTI_SetUpPermissions using <>aInspRcod
	
End if 
C_BOOLEAN:C305($0)
C_POINTER:C301($1; $Array_ptr)
$Array_ptr:=$1
C_LONGINT:C283($2; $District_L; $InspRespIndex_L)
$District_L:=$2
$InspRespIndex_L:=Find in array:C230(<>aInspRcod; "DIST"+String:C10($District_L))
C_BOOLEAN:C305($AllowThisDistr_b)
$AllowThisDistr_b:=False:C215
If ($InspRespIndex_L>0)
	$AllowThisDistr_b:=$Array_ptr->{$InspRespIndex_L}
End if 
$0:=True:C214
Case of 
	: (User in group:C338(<>CurrentUser_Name; "Design Access Group"))
	: ($Array_ptr->{Size of array:C274($Array_ptr->)})  //allow ALL
	: ($AllowThisDistr_b)  //Allow in this district
	Else 
		$0:=False:C215
End case 

//End NTI_CheckTownSelection

