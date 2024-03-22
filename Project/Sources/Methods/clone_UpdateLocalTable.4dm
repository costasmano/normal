//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 07/30/13, 14:26:10
//----------------------------------------------------
//Method: clone_UpdateLocalTable
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
C_LONGINT:C283($1; $2; $TableNumber_l; $Loop_l; $Type_l; $Length_l; $ArrayPosition_L)
C_BOOLEAN:C305($Indexed_b; $Unique_b; $Invisible_b)
$ArrayPosition_L:=$2
$TableNumber_l:=$1
C_POINTER:C301($Field_Ptr; $Variable_ptr)
C_TEXT:C284($VariableExtension_txt)

For ($Loop_l; 1; Get last field number:C255($TableNumber_l))
	If (Is field number valid:C1000($TableNumber_l; $Loop_l))
		GET FIELD PROPERTIES:C258($TableNumber_l; $Loop_l; $Type_l; $Length_l; $Indexed_b; $Unique_b; $Invisible_b)
		$Field_Ptr:=Field:C253($TableNumber_l; $Loop_l)
		Case of 
			: ($Type_l=Is alpha field:K8:1) | ($Type_l=Is text:K8:3)
				$VariableExtension_txt:="_atxt"
			: ($Type_l=Is real:K8:4)
				$VariableExtension_txt:="_ar"
			: ($Type_l=Is integer:K8:5) | ($Type_l=Is longint:K8:6)
				$VariableExtension_txt:="_aL"
			: ($Type_l=Is date:K8:7)
				$VariableExtension_txt:="_ad"
			: ($Type_l=Is time:K8:8)
				$VariableExtension_txt:="_aL"
			: ($Type_l=Is boolean:K8:9)
				$VariableExtension_txt:="_ab"
			: ($Type_l=Is picture:K8:10)
				$VariableExtension_txt:="_ap"
			: ($Type_l=Is BLOB:K8:12)
				//$VariableExtension_txt:="_ablb"
			Else 
				$VariableExtension_txt:=""
		End case 
		
		Case of 
			: ($Type_l=7)  //  `type 7 is subtable we are not using any data from them
			: ($Type_l=Is BLOB:K8:12)  // no blob arrays
			Else 
				$Variable_ptr:=Get pointer:C304("v_"+String:C10($TableNumber_l)+"_"+String:C10($Loop_l; "000")+$VariableExtension_txt)
				$Field_Ptr->:=$Variable_ptr->{$ArrayPosition_L}
		End case 
		
	End if 
End for 
//End clone_UpdateLocalTable

