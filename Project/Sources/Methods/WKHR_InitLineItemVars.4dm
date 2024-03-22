//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/04/05, 18:03:02
	// ----------------------------------------------------
	// Method: WKHR_InitLineItemVars
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM21
	// Modified by: costasmanousakis-(Designer)-06/19/08, 08:37:55
	Mods_2008_CM_5403  // ("WKHRS")
	// Modified by: costasmanousakis-(Designer)-(2/10/09 22:17:44)
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 11:56:23  `("WKHRMODS")
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_TEXT:C284(Line_ItemNo; LineDesc_Text; ItemCmmts_Txt)
C_REAL:C285(wkHr_Real_1; wkHr_Real_2; wkHr_Real_3; wkHr_Real_4; wkHr_Real_5; wkHr_Real_6; wkHr_Real_7)

C_REAL:C285(ReviewItm_1; ReviewItm_2; ReviewItm_3; ReviewItm_4; ReviewItm_5; ReviewItm_6; ReviewItm_7)
C_REAL:C285(OfficeEstItm_1; OfficeEstItm_2; OfficeEstItm_3; OfficeEstItm_4; OfficeEstItm_5; OfficeEstItm_6; OfficeEstItm_7)

C_REAL:C285(SubItmV1_1; SubItmV1_2; SubItmV1_3; SubItmV1_4; SubItmV1_5; SubItmV1_6; SubItmV1_7)
C_REAL:C285(SubItmV2_1; SubItmV2_2; SubItmV2_3; SubItmV2_4; SubItmV2_5; SubItmV2_6; SubItmV2_7)
C_REAL:C285(SubItmV3_1; SubItmV3_2; SubItmV3_3; SubItmV3_4; SubItmV3_5; SubItmV3_6; SubItmV3_7)
C_REAL:C285(SubItmV4_1; SubItmV4_2; SubItmV4_3; SubItmV4_4; SubItmV4_5; SubItmV4_6; SubItmV4_7)
C_REAL:C285(SubItmV5_1; SubItmV5_2; SubItmV5_3; SubItmV5_4; SubItmV5_5; SubItmV5_6; SubItmV5_7)
C_REAL:C285(SubItmV6_1; SubItmV6_2; SubItmV6_3; SubItmV6_4; SubItmV6_5; SubItmV6_6; SubItmV6_7)
C_REAL:C285(SubItmV7_1; SubItmV7_2; SubItmV7_3; SubItmV7_4; SubItmV7_5; SubItmV7_6; SubItmV7_7)
C_REAL:C285(SubItmV8_1; SubItmV8_2; SubItmV8_3; SubItmV8_4; SubItmV8_5; SubItmV8_6; SubItmV8_7)
C_REAL:C285(SubItmV9_1; SubItmV9_2; SubItmV9_3; SubItmV9_4; SubItmV9_5; SubItmV9_6; SubItmV9_7)

C_REAL:C285(RevSubItmV1_1; RevSubItmV1_2; RevSubItmV1_3; RevSubItmV1_4; RevSubItmV1_5; RevSubItmV1_6; RevSubItmV1_7)
C_REAL:C285(RevSubItmV2_1; RevSubItmV2_2; RevSubItmV2_3; RevSubItmV2_4; RevSubItmV2_5; RevSubItmV2_6; RevSubItmV2_7)
C_REAL:C285(RevSubItmV3_1; RevSubItmV3_2; RevSubItmV3_3; RevSubItmV3_4; RevSubItmV3_5; RevSubItmV3_6; RevSubItmV3_7)
C_REAL:C285(RevSubItmV4_1; RevSubItmV4_2; RevSubItmV4_3; RevSubItmV4_4; RevSubItmV4_5; RevSubItmV4_6; RevSubItmV4_7)
C_REAL:C285(RevSubItmV5_1; RevSubItmV5_2; RevSubItmV5_3; RevSubItmV5_4; RevSubItmV5_5; RevSubItmV5_6; RevSubItmV5_7)
C_REAL:C285(RevSubItmV6_1; RevSubItmV6_2; RevSubItmV6_3; RevSubItmV6_4; RevSubItmV6_5; RevSubItmV6_6; RevSubItmV6_7)
C_REAL:C285(RevSubItmV7_1; RevSubItmV7_2; RevSubItmV7_3; RevSubItmV7_4; RevSubItmV7_5; RevSubItmV7_6; RevSubItmV7_7)
C_REAL:C285(RevSubItmV8_1; RevSubItmV8_2; RevSubItmV8_3; RevSubItmV8_4; RevSubItmV8_5; RevSubItmV8_6; RevSubItmV8_7)
C_REAL:C285(RevSubItmV9_1; RevSubItmV9_2; RevSubItmV9_3; RevSubItmV9_4; RevSubItmV9_5; RevSubItmV9_6; RevSubItmV9_7)

C_TEXT:C284(SubItDsc_1; SubItDsc_2; SubItDsc_3; SubItDsc_4; SubItDsc_5; SubItDsc_6; SubItDsc_7; SubItDsc_8; SubItDsc_9)

C_REAL:C285(OffEstSubItmV1_1; OffEstSubItmV1_2; OffEstSubItmV1_3; OffEstSubItmV1_4; OffEstSubItmV1_5; OffEstSubItmV1_6; OffEstSubItmV1_7)
C_REAL:C285(OffEstSubItmV2_1; OffEstSubItmV2_2; OffEstSubItmV2_3; OffEstSubItmV2_4; OffEstSubItmV2_5; OffEstSubItmV2_6; OffEstSubItmV2_7)
C_REAL:C285(OffEstSubItmV3_1; OffEstSubItmV3_2; OffEstSubItmV3_3; OffEstSubItmV3_4; OffEstSubItmV3_5; OffEstSubItmV3_6; OffEstSubItmV3_7)
C_REAL:C285(OffEstSubItmV4_1; OffEstSubItmV4_2; OffEstSubItmV4_3; OffEstSubItmV4_4; OffEstSubItmV4_5; OffEstSubItmV4_6; OffEstSubItmV4_7)
C_REAL:C285(OffEstSubItmV5_1; OffEstSubItmV5_2; OffEstSubItmV5_3; OffEstSubItmV5_4; OffEstSubItmV5_5; OffEstSubItmV5_6; OffEstSubItmV5_7)
C_REAL:C285(OffEstSubItmV6_1; OffEstSubItmV6_2; OffEstSubItmV6_3; OffEstSubItmV6_4; OffEstSubItmV6_5; OffEstSubItmV6_6; OffEstSubItmV6_7)
C_REAL:C285(OffEstSubItmV7_1; OffEstSubItmV7_2; OffEstSubItmV7_3; OffEstSubItmV7_4; OffEstSubItmV7_5; OffEstSubItmV7_6; OffEstSubItmV7_7)
C_REAL:C285(OffEstSubItmV8_1; OffEstSubItmV8_2; OffEstSubItmV8_3; OffEstSubItmV8_4; OffEstSubItmV8_5; OffEstSubItmV8_6; OffEstSubItmV8_7)
C_REAL:C285(OffEstSubItmV9_1; OffEstSubItmV9_2; OffEstSubItmV9_3; OffEstSubItmV9_4; OffEstSubItmV9_5; OffEstSubItmV9_6; OffEstSubItmV9_7)
C_TEXT:C284(OffEstSubItDsc_1; OffEstSubItDsc_2; OffEstSubItDsc_3; OffEstSubItDsc_4; OffEstSubItDsc_5; OffEstSubItDsc_6; OffEstSubItDsc_7; OffEstSubItDsc_8; OffEstSubItDsc_9)

C_LONGINT:C283(WKHR_MaxNumSubBreakDwn; WKHR_SubItemCount; WKHR_OffEstSubItemCount)  //Command Replaced was o_C_INTEGER
WKHR_MaxNumSubBreakDwn:=9
WKHR_SubItemCount:=0
ReviewItm_1:=0
ReviewItm_2:=0
ReviewItm_3:=0
ReviewItm_4:=0
ReviewItm_5:=0
ReviewItm_6:=0
ReviewItm_7:=0
OfficeEstItm_1:=0
OfficeEstItm_2:=0
OfficeEstItm_3:=0
OfficeEstItm_4:=0
OfficeEstItm_5:=0
OfficeEstItm_6:=0
OfficeEstItm_7:=0
WKHR_OffEstSubItemCount:=0
C_LONGINT:C283($i; $ic)
C_POINTER:C301($Variable_ptr)
For ($i; 1; WKHR_MaxNumSubBreakDwn)
	$Variable_ptr:=Get pointer:C304("SubItDsc_"+String:C10($i))
	$Variable_ptr->:=""
	For ($ic; 1; (WKHR_CategoryCount_i+1))
		$Variable_ptr:=Get pointer:C304("SubItmV"+String:C10($i)+"_"+String:C10($ic))
		$Variable_ptr->:=0
		$Variable_ptr:=Get pointer:C304("RevSubItmV"+String:C10($i)+"_"+String:C10($ic))
		$Variable_ptr->:=0
	End for 
End for 

C_POINTER:C301($Variable_ptr)
For ($i; 1; WKHR_MaxNumSubBreakDwn)
	$Variable_ptr:=Get pointer:C304("OffEstSubItDsc_"+String:C10($i))
	$Variable_ptr->:=""
	For ($ic; 1; (WKHR_CategoryCount_i+1))
		$Variable_ptr:=Get pointer:C304("OffEstSubItmV"+String:C10($i)+"_"+String:C10($ic))
		$Variable_ptr->:=0
	End for 
End for 