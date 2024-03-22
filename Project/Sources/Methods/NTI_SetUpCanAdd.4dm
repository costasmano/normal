//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/03/15, 14:32:47
//----------------------------------------------------
//Method: NTI_SetUpCanAdd
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (11/3/15 14:32:50)
	// Modified by: Costas Manousakis-(Designer)-(10/13/17 17:09:53)
	Mods_2017_10
	//  `use the last element of NTI_ADDTunnelInfo_aB for ALL
End if 
C_BOOLEAN:C305($0)

$0:=True:C214
Case of 
	: (User in group:C338(<>CurrentUser_Name; "Design Access Group"))
	: (NTI_ADDTunnelInfo_aB{Size of array:C274(NTI_ADDTunnelInfo_aB)})  //allow ALL
	: (Find in array:C230(NTI_ADDTunnelInfo_aB; True:C214)>0)
	Else 
		$0:=False:C215
End case 

//End NTI_SetUpCanAdd