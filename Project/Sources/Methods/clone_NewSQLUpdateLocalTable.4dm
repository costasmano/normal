//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/07/14, 21:31:49
//----------------------------------------------------
//Method: clone_NewSQLUpdateLocalTable
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
C_LONGINT:C283($1; $TableNumber_l; $Loop_l; $Type_l; $Length_l)
C_BOOLEAN:C305($Indexed_b; $Unique_b; $Invisible_b)

$TableNumber_l:=$1


For ($Loop_l; 1; Get last field number:C255($TableNumber_l))
	If (Is field number valid:C1000($TableNumber_l; $Loop_l))
		If (TableFidTypes_al{$TableNumber_l}{$Loop_l}#7)  //type 7 is subtable we are not using any data from them
			TableFlds_aptr{$TableNumber_l}{$Loop_l}->:=TableFieldsVars_aptr{$TableNumber_l}{$Loop_l}->
		End if 
	Else   // do we want to report to log file the missed field
		
	End if 
End for 
//End clone_NewSQLUpdateLocalTable

