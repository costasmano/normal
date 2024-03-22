//%attributes = {"invisible":true}
//Method: FromSQLSelect
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/13/14, 14:58:01
	// ----------------------------------------------------
	//Created : 
	Mods_2014_01
End if 
//
//
C_LONGINT:C283($wid_L)

$wid_L:=Open form window:C675("FromSQLSelectLB")
C_TEXT:C284(SQLStmt_txt; SQLResult_txt)
ARRAY BOOLEAN:C223(NewLB; 0)

SQLStmt_txt:=""
SQLStmt_txt:=SQLStmt_txt+"Select [Bridge MHD NBIS].BIN, [Bridge MHD NBIS].Item8, [Bridge MHD NBIS].BDEPT, [Bridge MHD NBIS].FHWARecord,"
SQLStmt_txt:=SQLStmt_txt+"[Bridge MHD NBIS].Item7, [Bridge MHD NBIS].Item6A "
SQLStmt_txt:=SQLStmt_txt+"FROM [Bridge MHD NBIS] "
SQLStmt_txt:=SQLStmt_txt+"WHERE cast([Bridge MHD NBIS].FHWARecord AS INT)=1  "
SQLStmt_txt:=SQLStmt_txt+"order by  [Bridge MHD NBIS].BDEPT, [Bridge MHD NBIS].BIN "
SQLStmt_txt:=SQLStmt_txt+"into LISTBOX :NewLB"

DIALOG:C40("FromSQLSelectLB")

CLOSE WINDOW:C154


//End FromSQLSelect