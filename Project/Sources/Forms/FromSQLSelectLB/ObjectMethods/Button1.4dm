//Method: Object Method: FromSQLSelectLB.Button1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/22/13, 18:14:46
	// ----------------------------------------------------
	//Created : 
	Mods_2014_01
End if 
//
SQLResult_txt:="Found "+String:C10(Size of array:C274(NewLB))+" records"
LISTBOX GET ARRAYS:C832(NewLB; arrColNames; arrHeaderNames; arrColVars; arrHeaderVars; arrColsVisible; arrStyles)

//End Object Method: FromSQLSelectLB.Button1