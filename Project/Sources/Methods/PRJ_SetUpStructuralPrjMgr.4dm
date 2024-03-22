//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_SetUpStructuralPrjMgr
// User name (OS): cjmiller
// Date and time: 11/30/06, 16:03:49
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_PRJSELECTION
End if 
C_POINTER:C301($1; $Table_ptr)
C_LONGINT:C283($2; $ReviewerID_l; $k)
$Table_ptr:=$1
$ReviewerID_l:=$2
PRJ_StructPrjMgr_txt:=""
PRJ_StructPrjMgrID_al:=0
PRJ_StructPrjMgr_atxt:=0
PRJ_StructPrjMgrID_al:=Find in array:C230(PRJ_StructPrjMgrID_al; $ReviewerID_l)
C_LONGINT:C283($Color_l)
$Color_l:=-15  //black

If (PRJ_StructPrjMgrID_al<1)
	If (Record number:C243($Table_ptr->)=New record:K29:1)
		PRJ_StructPrjMgr_txt:="None Selected"
	Else 
		If ($ReviewerID_l#0)
			$k:=Find in array:C230(aPeople_ID; $ReviewerID_l)
			If ($k>0)
				PRJ_StructPrjMgr_txt:=FN_LastNameFirst(aPeople{$k})
			Else 
				PRJ_StructPrjMgr_txt:="Unknown Person ID: "+String:C10($ReviewerID_l)
			End if 
			$Color_l:=-133
		Else 
			PRJ_StructPrjMgr_txt:="None Selected"
		End if 
	End if 
Else 
	PRJ_StructPrjMgr_atxt:=PRJ_StructPrjMgrID_al
	PRJ_StructPrjMgr_txt:=PRJ_StructPrjMgr_atxt{PRJ_StructPrjMgr_atxt}
	$Color_l:=-9
End if 

OBJECT SET RGB COLORS:C628(*; "PRJ_StructPrjMgr_txt_o"; Col_paletteToRGB(Abs:C99($Color_l)%256); Col_paletteToRGB(Abs:C99($Color_l)\256))  // **Replaced o OBJECT SET COLOR(*; "PRJ_StructPrjMgr_txt_o"; $Color_l)
//End PRJ_SetUpStructuralPrjMgr