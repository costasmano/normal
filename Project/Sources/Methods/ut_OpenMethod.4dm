//%attributes = {"invisible":true}
//Method: ut_OpenMethod
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 09/07/17, 11:54:20
	// ----------------------------------------------------
	//Created : 
	Mods_2017_09_bug
	C_TEXT:C284(ut_OpenMethod; $1)
	Mods_2019_07  //Modify code to save better folder structure when saving methdods and to identify Form methdods
	//Modified by: Chuck Miller (7/16/19 17:02:22)
End if 

C_TEXT:C284($Code_txt)

C_TEXT:C284($1; $MethodName_txt)
$MethodName_txt:=$1
If (Type:C295(<>DesignMethodNames_atxt)=Is undefined:K8:13)
	ARRAY TEXT:C222(<>DesignMethodNames_atxt; 0)
	ARRAY TEXT:C222(<>DesignMethodCode_atxt; 0)
End if 
C_LONGINT:C283($Loc_L)
$Loc_L:=Find in array:C230(<>DesignMethodNames_atxt; $MethodName_txt)
If ($Loc_L>0)
	
Else 
	APPEND TO ARRAY:C911(<>DesignMethodNames_atxt; $MethodName_txt)
	GET MACRO PARAMETER:C997(Full method text:K5:17; $Code_txt)
	APPEND TO ARRAY:C911(<>DesignMethodCode_atxt; $Code_txt)
End if 

//End ut_OpenMethod