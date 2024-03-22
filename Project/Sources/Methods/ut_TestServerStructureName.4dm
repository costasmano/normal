//%attributes = {"invisible":true}
//Method: ut_TestServerStructureName
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//----------------------------------------------------
	//User name (OS): Charles Miller
	//Date and time: 10/28/11, 14:00:25
	//----------------------------------------------------
	//Ugrade to v11
	//Modified by: Charles Miller (10/28/11 14:00:26)
	
	// Modified by: Costas Manousakis-(Designer)-(7/15/20 09:30:43)
	Mods_2020_07
	//  `added use of Method called on error
End if 
C_LONGINT:C283($0; $Error_l)
$Error_l:=1
SeverStructureName_txt:=""
C_TEXT:C284(SQLQuery_txt)
SQLQuery_txt:="SELECT {fn ut_RetrunServerStructureName() AS TEXT} FROM Preferences INTO :SeverStructureName_txt;"
C_TEXT:C284($errmethod)
$errmethod:=Method called on error:C704
ON ERR CALL:C155("SQL_ERROR")  //

Begin SQL
	EXECUTE IMMEDIATE :SQLQuery_txt;
End SQL

ON ERR CALL:C155($errmethod)  //

//Get the password
If (Position:C15(<>Destination; SeverStructureName_txt)>0)
Else 
	ut_SQLLogout
	$Error_l:=-9
End if 

$0:=$Error_l
//End ut_TestServerStructureName