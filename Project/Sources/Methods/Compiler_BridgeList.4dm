//%attributes = {"invisible":true}
//Method: Compiler_BridgeList
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/11/13, 10:25:12
	// ----------------------------------------------------
	//Created : 
	Mods_2013_09
	Mods_2019_07  //Create new list box NewNBIS_StackInfoform to test as width and height changed
	//Modified by: Chuck Miller (7/18/19 12:51:34)
	Mods_2019_09  //Add ability to query bridgle list in any field listed
	Mods_2020_02  //Complete conversion of NBIS stack and MBTA NBIS Stack to List boxes
	
End if 
//
ARRAY POINTER:C280(BRGDESLIST_SORTFLD_AP; 0)
ARRAY POINTER:C280(BRGDESLIST_SORTPTR_AP; 0)
ARRAY POINTER:C280(BRGLIST_SORTFLD_AP; 0)
ARRAY POINTER:C280(BRGLIST_SORTPTR_AP; 0)
ARRAY TEXT:C222(<>BridgeSearchArray_atxt; 0)
If (False:C215)
	
	C_LONGINT:C283(VSORTBDEPT)
	C_LONGINT:C283(VSORTBIN)
	C_LONGINT:C283(VSORTBRNAME)
	C_LONGINT:C283(VSORTITEM6A)
	C_LONGINT:C283(VSORTITEM7)
	C_LONGINT:C283(VSORTITEM8)
	C_LONGINT:C283(VSORTLINE)
	C_LONGINT:C283(VSORTTYPE)
	C_TEXT:C284(GEN_SORTLISTCMD_TXT)
	C_BOOLEAN:C305(BRGList_TunnelsOnly_b)
	C_LONGINT:C283(WPosLeft_L; WPosTop_L; WPosRight_L; WPosBottom_L)
	
End if 
//End Compiler_BridgeList