//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 07/23/13, 16:27:38
//----------------------------------------------------
//Method: Clone_ReturnFieldnumber
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	
End if 
C_LONGINT:C283($1; $Loop_l)
C_TEXT:C284($2; $FieldName_txt)
C_LONGINT:C283($0)

For ($Loop_l; 1; Get last field number:C255($1))
	If (Is field number valid:C1000($1; $Loop_l))
		$FieldName_txt:=Field name:C257($1; $Loop_l)
		If ($FieldName_txt=$2)
			$0:=$Loop_l
			$Loop_l:=Get last field number:C255($1)+1
		End if 
	End if 
End for 

//End Clone_ReturnFieldPointer