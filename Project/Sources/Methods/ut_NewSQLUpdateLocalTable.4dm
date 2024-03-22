//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/21/11, 15:57:38
//----------------------------------------------------
//Method: ut_NewSQLUpdateLocalTable
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2017_08_bug  // Make sure that we do not include [Activity Log]Activity_Log_UUIDKey_s field in saving recorde data
End if 
C_LONGINT:C283($1; $TableNumber_l; $Loop_l; $Type_l; $Length_l)


$TableNumber_l:=$1


For ($Loop_l; 1; Get last field number:C255($TableNumber_l))
	If (Is field number valid:C1000($TableNumber_l; $Loop_l))
		GET FIELD PROPERTIES:C258($TableNumber_l; $Loop_l; $Type_L; $Length_L)
		If ($Type_L=Is alpha field:K8:1) & ($Length_L=0)
		Else 
			//RESOLVE POINTER(TableFieldsVariables_aptr{$TableNumber_l}{$Loop_l};$VariableName_txt;$TableNo_l;$FieldNo_l)
			//$FieldName_txt:=Field name(TableFields_aptr{$TableNumber_l}{$Loop_l})
			//$Type_l:=Type(TableFieldsVariables_aptr{$TableNumber_l}{$Loop_l}->)
			//$Type1_l:=Type(TableFields_aptr{$TableNumber_l}{$Loop_l}->)
			//
			//ALERT("$Loop_l is --> "+String($Loop_l)+"variable pointer is "+$VariableName_txt+" field name is "+$FieldName_txt+" variable type is "+String($Type_l)+" field type "+String($Type1_l))
			
			If (TableFidTypes_al{$TableNumber_l}{$Loop_l}#7)  //type 7 is subtable we are not using any data from them
				TableFlds_aptr{$TableNumber_l}{$Loop_l}->:=TableFieldsVars_aptr{$TableNumber_l}{$Loop_l}->
			End if 
		End if 
	Else   // do we want to report to log file the mised field
		
	End if 
End for 
//End ut_NewSQLUpdateLocalTable

