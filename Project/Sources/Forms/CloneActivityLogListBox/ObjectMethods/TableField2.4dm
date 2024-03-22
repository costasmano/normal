
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 03/15/12, 11:56:55
//----------------------------------------------------
//Method: Object Method: CloneActivityLogListBox.TableNames_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_03  //r001
	//Modified by: Charles Miller (3/15/12 11:56:56)
	
End if 
If (TableNames_atxt{TableNames_atxt}="Activity Log")
	ALERT:C41("You may not choose that table")
Else 
	Compiler_LB
	C_LONGINT:C283($Loop_l; $TableNumber_l)
	C_POINTER:C301($Table_ptr)
	
	$TableNumber_l:=TableNumber_al{TableNames_atxt}
	$Table_ptr:=Table:C252($TableNumber_l)
	LISTBOX SET TABLE SOURCE:C1013(*; "SelectListBox"; $TableNumber_l)
	
	LISTBOX DELETE COLUMN:C830(*; "SelectListBox"; 1; 99)
	
	
	ARRAY TEXT:C222(FieldNames_atxt; 0)
	ARRAY LONGINT:C221(FieldNumbers_al; 0)
	
	
	
	For ($Loop_l; 1; Get last field number:C255($TableNumber_l))
		If (Is field number valid:C1000($TableNumber_l; $Loop_l))
			APPEND TO ARRAY:C911(FieldNumbers_al; $Loop_l)
			APPEND TO ARRAY:C911(FieldNames_atxt; Field name:C257($TableNumber_l; $Loop_l))
		End if 
	End for 
	QUERY:C277($Table_ptr->)
	SET WINDOW TITLE:C213("Clone Activity Log for "+String:C10(Records in selection:C76($Table_ptr->))+" "+TableNames_atxt{TableNames_atxt})
	
End if 
//End Object Method: CloneActivityLogListBox.TableNames_atxt

