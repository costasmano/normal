//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 03/25/15, 13:04:21
//----------------------------------------------------
//Method: LSS_SetUpPermissions
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (3/25/15 16:29:37)
End if 
ARRAY BOOLEAN:C223(LSS_ADDInventory_aB; 0)
ARRAY BOOLEAN:C223(LSS_DELInventory_aB; 0)
ARRAY BOOLEAN:C223(LSS_MODInventory_aB; 0)
ARRAY BOOLEAN:C223(LSS_ADDInspection_aB; 0)
ARRAY BOOLEAN:C223(LSS_DELInspection_aB; 0)
ARRAY BOOLEAN:C223(LSS_MODInspection_aB; 0)

ARRAY BOOLEAN:C223(LSS_ADDInventory_aB; 7)
ARRAY BOOLEAN:C223(LSS_DELInventory_aB; 7)
ARRAY BOOLEAN:C223(LSS_MODInventory_aB; 7)
ARRAY BOOLEAN:C223(LSS_ADDInspection_aB; 7)
ARRAY BOOLEAN:C223(LSS_DELInspection_aB; 7)
ARRAY BOOLEAN:C223(LSS_MODInspection_aB; 7)
C_LONGINT:C283($Loop_l)
READ ONLY:C145([PERS_Groups:109])
READ ONLY:C145([PERS_GroupMembers:110])
For ($Loop_l; 1; 6)
	
	LSS_ADDInventory_aB{$Loop_l}:=(GRP_UserInGroup("LSS_ADDInventory_D"+String:C10($Loop_L))=1)
	LSS_DELInventory_aB{$Loop_l}:=(GRP_UserInGroup("LSS_DELInventory_D"+String:C10($Loop_L))=1)
	LSS_MODInventory_aB{$Loop_l}:=(GRP_UserInGroup("LSS_MODInventory_D"+String:C10($Loop_L))=1)
	LSS_ADDInspection_aB{$Loop_l}:=(GRP_UserInGroup("LSS_ADDInspection_D"+String:C10($Loop_L))=1)
	LSS_DELInspection_aB{$Loop_l}:=(GRP_UserInGroup("LSS_DELInspection_D"+String:C10($Loop_L))=1)
	LSS_MODInspection_aB{$Loop_l}:=(GRP_UserInGroup("LSS_MODInspection_D"+String:C10($Loop_L))=1)
	
End for 
$Loop_l:=7
LSS_ADDInventory_aB{$Loop_l}:=(GRP_UserInGroup("LSS_ADDInventory_ALL")=1)
LSS_DELInventory_aB{$Loop_l}:=(GRP_UserInGroup("LSS_DELInventory_ALL")=1)
LSS_MODInventory_aB{$Loop_l}:=(GRP_UserInGroup("LSS_MODInventory_ALL")=1)
LSS_ADDInspection_aB{$Loop_l}:=(GRP_UserInGroup("LSS_ADDInspection_ALL")=1)
LSS_DELInspection_aB{$Loop_l}:=(GRP_UserInGroup("LSS_DELInspection_ALL")=1)
LSS_MODInspection_aB{$Loop_l}:=(GRP_UserInGroup("LSS_MODInspection_ALL")=1)




//LSS_DELInventory_aB{$Loop_l}:=(GRP_UserInGroup ("LSS_DELInventory_ALL")=1)
//LSS_MODInventory_aB{$Loop_l}:=(GRP_UserInGroup ("LSS_MODInventory_ALL")=1)
//LSS_ADDInspection_aB{$Loop_l}:=(GRP_UserInGroup ("LSS_ADDInspection_ALL")=1)
//LSS_DELInspection_aB{$Loop_l}:=(GRP_UserInGroup ("LSS_DELInspection_ALL")=1)
//LSS_MODInspection_aB{$Loop_l}:=(GRP_UserInGroup ("LSS_MODInspection_ALL")=1)


//End LSS_SetUpPermissions

