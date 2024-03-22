//%attributes = {"invisible":true}
//Method: LSS_FillElementMemberLines
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 09/13/18, 12:31:40
	// ----------------------------------------------------
	//Created : 
	Mods_2018_09
	// Modified by: Costas Manousakis-(Designer)-(1/30/19 14:58:16)
	Mods_2019_01_bug
	//  `fix printing of Deficiency to include the priority - CallReference #603
End if 
//
C_LONGINT:C283($1; $ArrayPosition_L; $2; $PagePosition_l)
$ArrayPosition_L:=$1
$PagePosition_l:=$2
C_POINTER:C301($ptr)

$ptr:=Get pointer:C304("vMember"+String:C10($PagePosition_l))
$ptr->:=v_163_007_atxt{$ArrayPosition_L}
$ptr:=Get pointer:C304("vCrack"+String:C10($PagePosition_l))
$ptr->:=LSS_Crack_atxt{$ArrayPosition_L}
$ptr:=Get pointer:C304("vWeld"+String:C10($PagePosition_l))
$ptr->:=v_163_014_atxt{$ArrayPosition_L}
$ptr:=Get pointer:C304("vRemarks"+String:C10($PagePosition_l))
If (LSS_AddtoCommentsPAGE_AB{$ArrayPosition_L})
	$ptr->:="See remarks in comments section."
Else 
	$ptr->:=v_163_008_atxt{$ArrayPosition_L}
End if 
Case of   //added this to fit text.
	: (Length:C16($ptr->)>29)
		OBJECT SET FONT SIZE:C165($ptr->; 8)
	: (Length:C16($ptr->)>27)
		OBJECT SET FONT SIZE:C165($ptr->; 9)
	: (Length:C16($ptr->)>24)
		OBJECT SET FONT SIZE:C165($ptr->; 10)
End case 
$ptr:=Get pointer:C304("vprevR"+String:C10($PagePosition_l))
$ptr->:=v_163_013_atxt{$ArrayPosition_L}
$ptr:=Get pointer:C304("vR"+String:C10($PagePosition_l))
$ptr->:=v_163_004_atxt{$ArrayPosition_L}
$ptr:=Get pointer:C304("vDEF"+String:C10($PagePosition_l))
$ptr->:=v_163_005_atxt{$ArrayPosition_L}
$ptr->:=v_163_005_atxt{$ArrayPosition_L}+"-"+v_163_006_atxt{$ArrayPosition_L}


//End LSS_FillElementMemberLines