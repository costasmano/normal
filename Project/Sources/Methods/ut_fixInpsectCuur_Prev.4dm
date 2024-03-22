//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 06/09/15, 15:38:36
//----------------------------------------------------
//Method: ut_fixInpsectCuur_Prev
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
ARRAY LONGINT:C221($RefRatingID_aL; 9)
ARRAY TEXT:C222($RefRatingDes_atxt; 9)
$RefRatingID_aL{1}:=1
$RefRatingID_aL{2}:=2
$RefRatingID_aL{3}:=3
$RefRatingID_aL{4}:=4
$RefRatingID_aL{5}:=5
$RefRatingID_aL{6}:=6
$RefRatingID_aL{7}:=7
$RefRatingID_aL{8}:=8
$RefRatingID_aL{9}:=0
$RefRatingDes_atxt{1}:="N"
$RefRatingDes_atxt{2}:="1"
$RefRatingDes_atxt{3}:="2"
$RefRatingDes_atxt{4}:="3"
$RefRatingDes_atxt{5}:="4"
$RefRatingDes_atxt{6}:="H"
$RefRatingDes_atxt{7}:="R"
$RefRatingDes_atxt{8}:="X"
$RefRatingDes_atxt{9}:=""

READ WRITE:C146([LSS_Inspection:164])
C_LONGINT:C283($Loop_L; $Loc_L)
ALL RECORDS:C47([LSS_Inspection:164])

For ($Loop_L; 1; Records in selection:C76([LSS_Inspection:164]))
	GOTO SELECTED RECORD:C245([LSS_Inspection:164]; $Loop_L)
	
	$Loc_L:=Find in array:C230($RefRatingID_aL; Num:C11([LSS_Inspection:164]LSS_CondFoundationCurr_s:12))
	If ($Loc_L>0)
		[LSS_Inspection:164]LSS_CondFoundationCurr_s:12:=$RefRatingDes_atxt{$Loc_L}
	End if 
	
	$Loc_L:=Find in array:C230($RefRatingID_aL; Num:C11([LSS_Inspection:164]LSS_CondFoundationPrev_s:13))
	If ($Loc_L>0)
		[LSS_Inspection:164]LSS_CondFoundationPrev_s:13:=$RefRatingDes_atxt{$Loc_L}
	End if 
	$Loc_L:=Find in array:C230($RefRatingID_aL; Num:C11([LSS_Inspection:164]LSS_CondLuminaireCurr_s:22))
	If ($Loc_L>0)
		[LSS_Inspection:164]LSS_CondLuminaireCurr_s:22:=$RefRatingDes_atxt{$Loc_L}
	End if 
	
	$Loc_L:=Find in array:C230($RefRatingID_aL; Num:C11([LSS_Inspection:164]LSS_CondLuminairePrev_s:23))
	If ($Loc_L>0)
		[LSS_Inspection:164]LSS_CondLuminairePrev_s:23:=$RefRatingDes_atxt{$Loc_L}
	End if 
	
	
	$Loc_L:=Find in array:C230($RefRatingID_aL; Num:C11([LSS_Inspection:164]LSS_CondOverallCurr_s:24))
	If ($Loc_L>0)
		[LSS_Inspection:164]LSS_CondOverallCurr_s:24:=$RefRatingDes_atxt{$Loc_L}
	End if 
	
	$Loc_L:=Find in array:C230($RefRatingID_aL; Num:C11([LSS_Inspection:164]LSS_CondOverallPrev_s:25))
	If ($Loc_L>0)
		[LSS_Inspection:164]LSS_CondOverallPrev_s:25:=$RefRatingDes_atxt{$Loc_L}
	End if 
	
	
	$Loc_L:=Find in array:C230($RefRatingID_aL; Num:C11([LSS_Inspection:164]LSS_CondSignPanelsCurr_s:18))
	If ($Loc_L>0)
		[LSS_Inspection:164]LSS_CondSignPanelsCurr_s:18:=$RefRatingDes_atxt{$Loc_L}
	End if 
	
	$Loc_L:=Find in array:C230($RefRatingID_aL; Num:C11([LSS_Inspection:164]LSS_CondSignPanelsPrev_s:19))
	If ($Loc_L>0)
		[LSS_Inspection:164]LSS_CondSignPanelsPrev_s:19:=$RefRatingDes_atxt{$Loc_L}
	End if 
	
	$Loc_L:=Find in array:C230($RefRatingID_aL; Num:C11([LSS_Inspection:164]LSS_CondStructureCurr_s:14))
	If ($Loc_L>0)
		[LSS_Inspection:164]LSS_CondStructureCurr_s:14:=$RefRatingDes_atxt{$Loc_L}
	End if 
	
	$Loc_L:=Find in array:C230($RefRatingID_aL; Num:C11([LSS_Inspection:164]LSS_CondStructurePrev_s:15))
	If ($Loc_L>0)
		[LSS_Inspection:164]LSS_CondStructurePrev_s:15:=$RefRatingDes_atxt{$Loc_L}
	End if 
	
	$Loc_L:=Find in array:C230($RefRatingID_aL; Num:C11([LSS_Inspection:164]LSS_CondTrafficSafetyCurr_s:20))
	If ($Loc_L>0)
		[LSS_Inspection:164]LSS_CondTrafficSafetyCurr_s:20:=$RefRatingDes_atxt{$Loc_L}
	End if 
	
	$Loc_L:=Find in array:C230($RefRatingID_aL; Num:C11([LSS_Inspection:164]LSS_CondTrafficSafetyPrev_s:21))
	If ($Loc_L>0)
		[LSS_Inspection:164]LSS_CondTrafficSafetyPrev_s:21:=$RefRatingDes_atxt{$Loc_L}
	End if 
	
	
	$Loc_L:=Find in array:C230($RefRatingID_aL; Num:C11([LSS_Inspection:164]LSS_StructAttachmentsCurr_s:16))
	If ($Loc_L>0)
		[LSS_Inspection:164]LSS_StructAttachmentsCurr_s:16:=$RefRatingDes_atxt{$Loc_L}
	End if 
	
	$Loc_L:=Find in array:C230($RefRatingID_aL; Num:C11([LSS_Inspection:164]LSS_StructAttachmentsPrev_s:17))
	If ($Loc_L>0)
		[LSS_Inspection:164]LSS_StructAttachmentsPrev_s:17:=$RefRatingDes_atxt{$Loc_L}
	End if 
	SAVE RECORD:C53([LSS_Inspection:164])
	UNLOAD RECORD:C212([LSS_Inspection:164])
	
End for 

//End ut_fixInpsectCuur_Prev

