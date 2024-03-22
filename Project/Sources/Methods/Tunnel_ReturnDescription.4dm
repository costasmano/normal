//%attributes = {"invisible":true}
//Method: Tunnel_ReturnDescription
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/03/18, 14:53:24
	// ----------------------------------------------------
	//Created : 
	Mods_2018_05
End if 
//
C_POINTER:C301($1; $Field_ptr; $Array_ptr)
$Field_ptr:=$1

$0:="No Entry Made"
C_TEXT:C284($FieldName_txt; $Value_txt)
$FieldName_txt:=Field name:C257($Field_ptr)
Case of 
	: ($FieldName_txt="NTI_i8_s")
		$Array_ptr:=->NTI_i8_s_atxt
		$Value_txt:=$Field_ptr->+"@"
		
	: ($FieldName_txt="NTI_i9_L")
		$Array_ptr:=->NTI_i9_L_atxt
		$Value_txt:=String:C10($Field_ptr->)+"@"
		
	: ($FieldName_txt="NTI_A8_L")
		$Array_ptr:=->NTI_A8_L_atxt
		$Value_txt:=String:C10($Field_ptr->)+"@"
		
	: ($FieldName_txt="NTI_C1_s")
		$Array_ptr:=->NTI_C1_s_atxt
		$Value_txt:=$Field_ptr->+"@"
		
	: ($FieldName_txt="NTI_C2_s")
		$Array_ptr:=->NTI_C2_s_atxt
		$Value_txt:=$Field_ptr->+"@"
		
	: ($FieldName_txt="NTI_C3_s")
		$Array_ptr:=->NTI_C3_s_atxt
		$Value_txt:=$Field_ptr->+"@"
		
	: ($FieldName_txt="NTI_C4_s")
		$Array_ptr:=->NTI_C4_s_atxt
		$Value_txt:=$Field_ptr->+"@"
		
	: ($FieldName_txt="NTI_C7_L")
		$Array_ptr:=->NTI_C7_L_atxt
		$Value_txt:=String:C10($Field_ptr->)+"@"
		
	: ($FieldName_txt="NTI_C8_s")
		$Array_ptr:=->NTI_C8_s_atxt
		$Value_txt:=$Field_ptr->+"@"
		
	: ($FieldName_txt="NTI_L1_s")
		$Array_ptr:=->NTI_L1_s_atxt
		$Value_txt:=$Field_ptr->+"@"
		
	: ($FieldName_txt="NTI_L4_s")
		$Array_ptr:=->NTI_L4_s_atxt
		$Value_txt:=$Field_ptr->+"@"
		
	: ($FieldName_txt="NTI_N3_s")
		$Array_ptr:=->NTI_N3_s_atxt
		$Value_txt:=$Field_ptr->+"@"
		
	: ($FieldName_txt="NTI_S2_L")
		$Array_ptr:=->NTI_S2_L_atxt
		$Value_txt:=String:C10($Field_ptr->)+"@"
		
	: ($FieldName_txt="NTI_S3_L")
		$Array_ptr:=->NTI_S3_L_atxt
		$Value_txt:=String:C10($Field_ptr->)+"@"
		
	: ($FieldName_txt="NTI_S4_L")
		$Array_ptr:=->NTI_S4_L_atxt
		$Value_txt:=String:C10($Field_ptr->)+"@"
		
		
End case 
If (Length:C16($Value_txt)=1)
	$0:="("+$0+")"
Else 
	C_LONGINT:C283($arrayPos_L; $HyphenPos_L)
	$arrayPos_L:=Find in array:C230($Array_ptr->; $Value_txt)
	If ($arrayPos_L>0)
		$HyphenPos_L:=Position:C15("-"; $Array_ptr->{$arrayPos_L})
		If ($HyphenPos_L<1)
			$HyphenPos_L:=1
		End if 
		$0:=Substring:C12($Array_ptr->{$arrayPos_L}; $HyphenPos_L+2)
	End if 
	$0:="("+$0+")"
End if 
//End Tunnel_ReturnDescription