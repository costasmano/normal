//%attributes = {"invisible":true}
//Method: LSS_ClearSpecialMemberVariables
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 09/13/18, 10:33:38
	// ----------------------------------------------------
	//Created : 
	Mods_2018_09
End if 
//
C_LONGINT:C283($1)  //Number of elements on special memeber pages

C_POINTER:C301($Letter_ptr; $Member_ptr; $Crack_ptr; $Weld_ptr; $Remarks_ptr; $prev_ptr; $VR_ptr; $Def_ptr)
C_LONGINT:C283($Loop_L)
For ($Loop_L; 1; $1)
	
	$Letter_ptr:=Get pointer:C304("vLetter"+String:C10($Loop_L))
	$Letter_ptr->:=""
	
	$Member_ptr:=Get pointer:C304("vMember"+String:C10($Loop_L))
	$Member_ptr->:=""
	
	$Crack_ptr:=Get pointer:C304("vCrack"+String:C10($Loop_L))
	$Crack_ptr->:=""
	
	$Weld_ptr:=Get pointer:C304("vWeld"+String:C10($Loop_L))
	$Weld_ptr->:=""
	
	$Remarks_ptr:=Get pointer:C304("vRemarks"+String:C10($Loop_L))
	$Remarks_ptr->:=""
	
	$prev_ptr:=Get pointer:C304("vprevR"+String:C10($Loop_L))
	$prev_ptr->:=""
	
	$VR_ptr:=Get pointer:C304("vR"+String:C10($Loop_L))
	$VR_ptr->:=""
	
	$Def_ptr:=Get pointer:C304("vDEF"+String:C10($Loop_L))
	$Def_ptr->:=""
End for 
//End LSS_ClearSpecialMemberVariables