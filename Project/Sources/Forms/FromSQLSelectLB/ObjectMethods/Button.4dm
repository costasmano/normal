// Method: Object Method: FromSQLSelectLB.Button
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 09/22/13, 15:23:42
	// ----------------------------------------------------
	// First Release
	Mods_2013_09
End if 
//

//SET LISTBOX TABLE SOURCE(*;"NewLB";Table(->[Bridge MHD NBIS]))
If (False:C215)
	
	Begin SQL
		Select [Bridge MHD NBIS].BIN, [Bridge MHD NBIS].Item8, [Bridge MHD NBIS].BDEPT, [Bridge MHD NBIS].FHWARecord,
		[Bridge MHD NBIS].Item7, [Bridge MHD NBIS].Item6A
		FROM [Bridge MHD NBIS]
		WHERE cast([Bridge MHD NBIS].FHWARecord AS INT ) = 1
		order by  [Bridge MHD NBIS].BDEPT, [Bridge MHD NBIS].BIN
		into LISTBOX :NewLB
		
	End SQL
	
End if 

If (SQLStmt_txt#"")
	
	Begin SQL
		execute immediate :SQLStmt_txt
	End SQL
	//Begin SQL
	//execute immediate :SQLStmt_txt
	//End SQL
	
	LISTBOX GET ARRAYS:C832(NewLB; arrColNames; arrHeaderNames; arrColVars; arrHeaderVars; arrColsVisible; arrStyles)
	SQLResult_txt:="Found "+String:C10(Size of array:C274((arrColVars{1})->))+" records"
	REDRAW:C174(NewLB)
	REDRAW WINDOW:C456
	
End if 
//End Object Method: SelectListBox.Button