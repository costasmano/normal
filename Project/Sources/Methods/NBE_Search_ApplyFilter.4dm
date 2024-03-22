//%attributes = {"invisible":true}
//Method: NBE_Search_ApplyFilter
//Description
// Apply the filters selected in the search by NBEs dialog
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/24/17, 10:01:47
	// ----------------------------------------------------
	//Created : 
	Mods_2017_08
End if 
//
//Save current selection in element
C_LONGINT:C283($currkey_L)
$currkey_L:=PON_MASTERELEM_KEY_aL{PON_MASTERELEM_Desc_atxt}
C_TEXT:C284($SqlExecute_txt)
$SqlExecute_txt:="select [PON_ELEM_DEFS].ELEM_KEY, [PON_ELEM_DEFS].ELEM_SHORTNAME from [PON_ELEM_DEFS] "+\
"where "+\
"[PON_ELEM_DEFS].ELEM_PROTECT_SYS = 'N' and "+\
"[PON_ELEM_DEFS].ELEM_SMART_FLAG =  'N' "
If (PON_TYPES_Desc_atxt>1)
	$SqlExecute_txt:=$SqlExecute_txt+" and [PON_ELEM_DEFS].[ELEM_TYPE_KEY] = '"+PON_TYPES_Key_atxt{PON_TYPES_Desc_atxt}+"' "
End if 
If (PON_CATEGORIES_Desc_atxt>1)
	$SqlExecute_txt:=$SqlExecute_txt+" and [PON_ELEM_DEFS].[ELEM_CAT_KEY] = '"+PON_CATEGORIES_Key_atxt{PON_CATEGORIES_Desc_atxt}+"' "
End if 
If (PON_MATERIALS_Desc_atxt>1)
	$SqlExecute_txt:=$SqlExecute_txt+" and [PON_ELEM_DEFS].[ELEM_MAT_KEY] = '"+PON_MATERIALS_Key_atxt{PON_MATERIALS_Desc_atxt}+"' "
End if 

$SqlExecute_txt:=$SqlExecute_txt+" order by [PON_ELEM_DEFS].[ELEM_KEY] ASC INTO :PON_MASTERELEM_KEY_aL, :PON_MASTERELEM_Desc_atxt"
Begin SQL
	execute IMMEDIATE :$SqlExecute_txt ;
End SQL


If (Size of array:C274(PON_MASTERELEM_KEY_aL)>0)
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274(PON_MASTERELEM_Desc_atxt))
		PON_MASTERELEM_Desc_atxt{$loop_L}:=String:C10(PON_MASTERELEM_KEY_aL{$loop_L})+" : "+PON_MASTERELEM_Desc_atxt{$loop_L}
	End for 
	//try to restore the selected element
	C_LONGINT:C283($newPos_L)
	$newPos_L:=Find in array:C230(PON_MASTERELEM_KEY_aL; $currkey_L)
	
	If ($newPos_L>0)
		PON_MASTERELEM_Desc_atxt:=$newPos_L
	Else 
		PON_MASTERELEM_Desc_atxt:=0
	End if 
	
Else 
	//category / type / material combo does not result in any NBEs
	C_TEXT:C284($msg_txt)
	$msg_txt:="No NBEs were found for current filter of "
	If (PON_CATEGORIES_Desc_atxt>1)
		$msg_txt:=$msg_txt+" Category : "+PON_CATEGORIES_Desc_atxt{PON_CATEGORIES_Desc_atxt}
	End if 
	
	If (PON_TYPES_Desc_atxt>1)
		$msg_txt:=$msg_txt+" Type : "+PON_TYPES_Desc_atxt{PON_TYPES_Desc_atxt}
	End if 
	
	If (PON_MATERIALS_Desc_atxt>1)
		$msg_txt:=$msg_txt+" Material : "+PON_MATERIALS_Desc_atxt{PON_MATERIALS_Desc_atxt}
	End if 
	PON_MASTERELEM_Desc_atxt:=0
	$msg_txt:=$msg_txt+" !"
	ALERT:C41($msg_txt)
End if 
REDRAW WINDOW:C456

//End NBE_Search_ApplyFilter