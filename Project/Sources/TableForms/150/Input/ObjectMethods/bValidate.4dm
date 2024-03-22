
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/12/13, 11:16:27
//----------------------------------------------------
//Method: Object Method: [ScourCriticalInfo].Input.bValidate
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_02  //r001 ` 
	//Modified by: Charles Miller (2/12/13 11:16:28)
	
End if 
ARRAY POINTER:C280(ptr_Changes; 0; 0)
InitChangeStack(1)

C_BOOLEAN:C305($ChangesMade_b)
$ChangesMade_b:=False:C215
C_LONGINT:C283($TableNumber_l)
$TableNumber_l:=Table:C252(->[ScourCriticalInfo:150])
C_LONGINT:C283($Loop_l)
C_POINTER:C301($Field_ptr)

For ($Loop_l; 1; Get last field number:C255($TableNumber_l))
	If (Is field number valid:C1000($TableNumber_l; $Loop_l))
		$Field_ptr:=Field:C253($TableNumber_l; $Loop_l)
		If (Field name:C257($Field_ptr)="BIN")
			
		Else 
			If (($Field_ptr->)#Old:C35($Field_ptr->))
				PushChange(1; $Field_ptr)
				$ChangesMade_b:=True:C214
			End if 
		End if 
	End if 
End for 

If (Is new record:C668([ScourCriticalInfo:150])) | ($ChangesMade_b)
	If (Is new record:C668([ScourCriticalInfo:150]))
		LogNewRecord(->[ScourCriticalInfo:150]BIN:1; ->[ScourCriticalInfo:150]BIN:1; ->[ScourCriticalInfo:150]BIN:1; 0; "ScourCriticalInfo")
	End if 
	
	FlushGrpChgs(1; ->[ScourCriticalInfo:150]BIN:1; ->[ScourCriticalInfo:150]BIN:1; ->[ScourCriticalInfo:150]BIN:1; 0)
End if 

//End Object Method: [ScourCriticalInfo].Input.bValidate