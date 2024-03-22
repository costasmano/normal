//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 06/28/10, 13:31:56
// ----------------------------------------------------
// Method: ut_SQLUpdateLocalTable
// Description
// <caret/>
//
// Parameters
// ----------------------------------------------------


// Modified by: Charles Miller (6/28/10)
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:16:19) 
End if 
C_LONGINT:C283($1; $TableNumber_l; $Loop_l; $Type_l; $Length_l)
C_BOOLEAN:C305($Indexed_b; $Unique_b; $Invisible_b)

$TableNumber_l:=$1
C_POINTER:C301($Field_Ptr; $Variable_ptr)
C_TEXT:C284($VariableExtension_txt)

For ($Loop_l; 1; Get last field number:C255($TableNumber_l))
	If (Is field number valid:C1000($TableNumber_l; $Loop_l))
		GET FIELD PROPERTIES:C258($TableNumber_l; $Loop_l; $Type_l; $Length_l; $Indexed_b; $Unique_b; $Invisible_b)
		$Field_Ptr:=Field:C253($TableNumber_l; $Loop_l)
		Case of 
			: ($Type_l=Is alpha field:K8:1) | ($Type_l=Is text:K8:3)
				$VariableExtension_txt:="_txt"
			: ($Type_l=Is real:K8:4)
				$VariableExtension_txt:="_r"
			: ($Type_l=Is integer:K8:5) | ($Type_l=Is longint:K8:6)
				$VariableExtension_txt:="_l"
			: ($Type_l=Is date:K8:7)
				$VariableExtension_txt:="_d"
			: ($Type_l=Is time:K8:8)
				$VariableExtension_txt:="_tm"
			: ($Type_l=Is boolean:K8:9)
				$VariableExtension_txt:="_b"
			: ($Type_l=Is picture:K8:10)
				$VariableExtension_txt:="_p"
			: ($Type_l=Is BLOB:K8:12)
				$VariableExtension_txt:="_blb"
			Else 
				$VariableExtension_txt:=""
		End case 
		
		If ($Type_l#7)  //type 7 is subtable we are not using any data from them
			
			$Variable_ptr:=Get pointer:C304("v_"+String:C10($TableNumber_l)+"_"+String:C10($Loop_l; "000")+$VariableExtension_txt)
			$Field_Ptr->:=$Variable_ptr->
			
		End if 
		
	End if 
End for 