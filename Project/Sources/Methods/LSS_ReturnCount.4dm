//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 02/29/16, 11:27:14
//----------------------------------------------------
//Method: LSS_ReturnCount
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_02_bug  // 
	//Modified by: administrator (2/29/16 11:27:18)
	Compiler_LSS
End if 
C_LONGINT:C283($0; $Count_L)
C_TEXT:C284($1; $2; $3; $SQL_txt; $Quote_txt)
$Quote_txt:=Char:C90(Quote:K15:44)
$SQL_txt:="select count (*) from "+$1+" "+Char:C90(Carriage return:K15:38)
$SQL_txt:=$SQL_txt+" where "+$2+" like "+$Quote_txt+$3+$Quote_txt+" "+Char:C90(Carriage return:K15:38)
$SQL_txt:=$SQL_txt+"into  :$Count_L;"
Begin SQL
	execute immediate :$SQL_txt;
End SQL
$0:=$Count_L


//End LSS_ReturnCount

