// ----------------------------------------------------
// Form Method: "RecordCount.dlg"
// User name (OS): charlesmiller
// Date and time: 05/22/09, 11:10:32
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_05  //Add form that displays record counts
	
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY LONGINT:C221(RecordCount_al; 0)
		ARRAY TEXT:C222(TableName_atxt; 0)
		C_LONGINT:C283($Count_l; $Loop_l)
		$Count_l:=Get last table number:C254
		ARRAY LONGINT:C221(RecordCount_al; $Count_l)
		ARRAY TEXT:C222(TableName_atxt; $Count_l)
		For ($Loop_l; 1; $Count_l)
			RecordCount_al{$Loop_l}:=Records in table:C83(Table:C252($Loop_l)->)
			TableName_atxt{$Loop_l}:=Table name:C256($Loop_l)
		End for 
		//Start unsorted
		Header1:=0
		Header2:=0
		LISTBOX SELECT ROW:C912(ListBox1; 0; 2)
		
	: (Form event code:C388=On Unload:K2:2)
		ARRAY LONGINT:C221(RecordCount_al; 0)
		ARRAY TEXT:C222(TableName_atxt; 0)
		
End case 
//End Form Method: RecordCount.dlg