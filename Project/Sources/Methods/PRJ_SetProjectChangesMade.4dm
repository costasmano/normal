//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_SetProjectChangesMade
// User name (OS): cjmiller
// Date and time: 01/04/07, 16:47:33
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJMv2  //05/03/07, 16:19:35`Add update of 
	Mods_2007_CM10a
End if 
C_POINTER:C301($1; $2; $3; $Table_ptr; $ModifiedByFLD_ptr; $ModifiedTimeFLD_ptr)
$Table_ptr:=$1
$ModifiedByFLD_ptr:=$2
$ModifiedTimeFLD_ptr:=$3
If (Form event code:C388=On Validate:K2:3) | (Count parameters:C259=4)
	If (Count parameters:C259=1)
		If (Modified record:C314($Table_ptr->))
			ProjectChangesMade_b:=True:C214
		End if 
	Else 
		$ModifiedByFLD_ptr->:=Current user:C182
		$ModifiedTimeFLD_ptr->:=Substring:C12(ut_CreateTimeStamp; 1; 14)
		If (Modified record:C314($Table_ptr->))
			ProjectChangesMade_b:=True:C214
			$ModifiedByFLD_ptr->:=Current user:C182
			$ModifiedTimeFLD_ptr->:=Substring:C12(ut_CreateTimeStamp; 1; 14)
		End if 
	End if 
End if 
//End PRJ_SetProjectChangesMade