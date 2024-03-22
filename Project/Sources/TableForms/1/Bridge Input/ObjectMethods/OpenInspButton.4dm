If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/11/05, 00:41:31
	// ----------------------------------------------------
	// Method: Object Method: bOpenInsp
	// Description
	//Open selected Inspection.
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM11
	Mods_2005_VN01
	// Modified by: costasmanousakis-(Designer)-(12/14/2005 18:54:23)
	Mods_2005_CM20
	// Modified by: costasmanousakis-(Designer)-(2/21/2006 10:30:44)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(8/20/08 07:58:37)
	Mods_2008_CM_5404
	//  `Removed IF(False) encased code, case statement for input form, use method INSP_UpdateInspList
	// Modified by: costasmanousakis-(Designer)-(4/10/09 11:15:11)
	Mods_2009_04
	//  `Adjusted code to use Selected record number before and after to keep the record highlighted.
	//  `and method ut_LoadRecordInteractive to load the record.
	// Modified by: Costas Manousakis-(Designer)-(6/20/12 14:47:50)
	Mods_2012_06
	//  `Befoire getting the cell position of the listbox, check if there is anything in the hilite set - add it to the set at the end
	// Modified by: Costas Manousakis-(Designer)-(1/2/13 11:48:34)
	Mods_2013_01
	//  `Added call to ut_Read_Write_Tables ("WRITE";.. to set tables to RW before opening
	// Modified by: Costas Manousakis-(Designer)-(5/29/13 15:54:43)
	Mods_2013_05  // ****** BUG FIX
	//  `Replaced ut_Read_Write_Tables with  INSP_Read_Write_Tables ("WRITE") to make sure all needed tables are set to Write
	Mods_2013_05  //``` *** BUG FIX *****
	//  `Set name of listbox changed to LBSetBrgInsp
	// Modified by: Costas Manousakis-(Designer)-(6/12/19 11:18:43)
	Mods_2019_06
	//  `Unload all records when inspection is found to have link problems.
End if 

C_LONGINT:C283($rec_L; $column_l)
$rec_L:=Records in set:C195("LBSetBrgInsp")
If ($rec_L>0)
	LISTBOX GET CELL POSITION:C971(*; "Inspections"; $column_l; $rec_L)
End if 
If ($rec_L<1) | ($rec_L>Records in selection:C76([Combined Inspections:90]))
	
	ALERT:C41("You Must select an inspection to Edit/Open")
Else 
	INSP_Read_Write_Tables("WRITE")
	
	GOTO SELECTED RECORD:C245([Combined Inspections:90]; $rec_L)
	
	If (ut_LoadRecordInteractive(->[Combined Inspections:90]))
		
		//Get the current record
		SET CURSOR:C469(4)
		RELATE ONE:C42([Combined Inspections:90]NBISInspID:2)
		RELATE ONE:C42([Combined Inspections:90]BMSInspID:3)
		C_LONGINT:C283(vCurrentPontisID_L; vCurrentCombID_L)
		C_BOOLEAN:C305(vAllRelationsOK_B)
		vCurrentPontisID_L:=[BMS Inspections:44]Inspection ID:1
		vCurrentCombID_L:=[Combined Inspections:90]ID:6
		vAllRelationsOK_B:=True:C214
		If ([Combined Inspections:90]BMSInspID:3>0)
			If (vCurrentPontisID_L#[Combined Inspections:90]BMSInspID:3)
				vAllRelationsOK_B:=False:C215
			End if 
			If ([BMS Inspections:44]BIN:2#[Combined Inspections:90]BIN:1)
				vAllRelationsOK_B:=False:C215
			End if 
		End if 
		If (vAllRelationsOK_B)
			FORM SET INPUT:C55([Inspections:27]; "BlankCombinedStarter")
			MODIFY RECORD:C57([Inspections:27])
			// need to check if we are still in a transaction
			If (In transaction:C397)
				CANCEL TRANSACTION:C241
			End if 
			//added to clear locks on [activity log] table
			If (Is record loaded:C669([Activity Log:59]))
				UNLOAD RECORD:C212([Activity Log:59])
			End if 
			
			G_CloseAllTables(->[Bridge MHD NBIS:1])  //close all tables except the main one.
			
			INSP_UpdateInspList
			GOTO SELECTED RECORD:C245([Combined Inspections:90]; $rec_L)
			ADD TO SET:C119([Combined Inspections:90]; "LBSetBrgInsp")
		Else 
			ALERT:C41("There are database link problems with this inspection record!! Record cannot be l"+"oaded!!")
			G_CloseAllTables(->[Bridge MHD NBIS:1])  //close all tables except the main one.
			
			INSP_UpdateInspList
			GOTO SELECTED RECORD:C245([Combined Inspections:90]; $rec_L)
			ADD TO SET:C119([Combined Inspections:90]; "LBSetBrgInsp")
		End if 
		
	End if 
	
End if 