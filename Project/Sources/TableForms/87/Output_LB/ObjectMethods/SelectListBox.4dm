//Method: Object Method: [ServerProcesses].Output.SelectListBox
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/21/13, 09:50:40
	// ----------------------------------------------------
	//Created : 
	Mods_2013_11
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_BOOLEAN:C305(InDoubleClick_B)
		InDoubleClick_B:=False:C215
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Double Clicked:K2:5)
		//C_LONGINT($RecToOpen_L)
		//$RecToOpen_L:=Find in array(SelectListBox;True)
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			C_LONGINT:C283($column_l; $row_l)
			LISTBOX GET CELL POSITION:C971(SelectListBox; $column_l; $row_l)
			
			If (($row_l<1) & ($row_l>Records in selection:C76([ServerProcesses:87])))
				
			Else 
				READ WRITE:C146([ServerProcesses:87])
				GOTO SELECTED RECORD:C245([ServerProcesses:87]; $row_l)
				If (ut_LoadRecordInteractive(->[ServerProcesses:87]))
					FORM SET INPUT:C55([ServerProcesses:87]; "Input")
					MODIFY RECORD:C57([ServerProcesses:87])
					REDRAW:C174(SelectListBox)
				Else 
					UNLOAD RECORD:C212([ServerProcesses:87])
					READ ONLY:C145([ServerProcesses:87])
					LOAD RECORD:C52([ServerProcesses:87])
					DIALOG:C40([ServerProcesses:87]; "Input")
				End if 
				UNLOAD RECORD:C212([ServerProcesses:87])
			End if 
			
			InDoubleClick_B:=False:C215
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		
End case 

//End Object Method: [ServerProcesses].Output.SelectListBox