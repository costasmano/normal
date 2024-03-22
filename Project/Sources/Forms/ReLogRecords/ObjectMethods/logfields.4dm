//Method: ReLogRecords.logfields
// object method to collect specific fields to log instead of doing all fields
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/15/21, 16:39:18
	// ----------------------------------------------------
	//Created : 
	Mods_2021_07
End if 
//

ARRAY LONGINT:C221($Fields_aL; 0)
C_LONGINT:C283($selectedTable)
$selectedTable:=TableList_atxt
If (Is table number valid:C999($selectedTable))
	C_POINTER:C301($saveData_ptr)
	$saveData_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "fieldsToLog")
	C_OBJECT:C1216($fields_o)
	
	If (Length:C16($saveData_ptr->)>0)
		//load any existing data 
		$fields_o:=JSON Parse:C1218($saveData_ptr->)
		OB GET ARRAY:C1229($fields_o; "fieldstolog"; $Fields_aL)
	End if 
	
	Dev_pickFields(Table:C252(TableList_aL{$selectedTable}); ->$Fields_aL)
	
	OB SET ARRAY:C1227($fields_o; "fieldstolog"; $Fields_aL)
	ARRAY TEXT:C222($fieldnames_atxt; Size of array:C274($Fields_aL))
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($fieldnames_atxt))
		$fieldnames_atxt{$loop_L}:=Field name:C257(TableList_aL{$selectedTable}; $Fields_aL{$loop_L})
	End for 
	OB SET ARRAY:C1227($fields_o; "fieldnamestolog"; $fieldnames_atxt)
	
	C_TEXT:C284($fields_objtext)
	$fields_objtext:=JSON Stringify:C1217($fields_o)
	$saveData_ptr->:=$fields_objtext  //save the object in the form var
	
End if 

//End ReLogRecords.logfields