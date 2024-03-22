//%attributes = {"invisible":true}
//Method: ut_CompareParams
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/24/13, 08:48:22
	// ----------------------------------------------------
	//Created : 
	Mods_2013_05
End if 
//

C_TEXT:C284($IPAddress_txt; $TableName_txt)

$IPAddress_txt:=SQL_TestConnection

C_TEXT:C284(SQL_txt)

Compiler_FieldVariables(Table:C252(->[Parameters:107]))

ut_SQLConnect("Designer"; "caesar"; $IPAddress_txt)

SQL_txt:="Select [Parameters].[Description], "+Char:C90(Carriage return:K15:38)
SQL_txt:=SQL_txt+"[Parameters].[ParamType], "+Char:C90(Carriage return:K15:38)
SQL_txt:=SQL_txt+"[Parameters].[Value] "+Char:C90(Carriage return:K15:38)
SQL_txt:=SQL_txt+"from [Parameters] "+Char:C90(Carriage return:K15:38)
SQL_txt:=SQL_txt+"where [Parameters].[ParamCode] = :v_107_001_txt "+Char:C90(Carriage return:K15:38)
SQL_txt:=SQL_txt+"INTO :v_107_002_txt, :v_107_004_l, :v_107_003_txt;  "+Char:C90(Carriage return:K15:38)

ALL RECORDS:C47([Parameters:107])
QUERY:C277([Parameters:107])
C_BOOLEAN:C305($same_b)
FIRST RECORD:C50([Parameters:107])
While (Not:C34(End selection:C36([Parameters:107])))
	v_107_001_txt:=[Parameters:107]ParamCode:1
	Begin SQL
		execute Immediate :SQL_txt;
	End SQL
	$same_b:=False:C215
	Case of 
		: (Not:C34([Parameters:107]Description:2=v_107_002_txt))
		: (Not:C34([Parameters:107]ParamType:4=v_107_004_l))
		: (Not:C34([Parameters:107]Value:3=v_107_003_txt))
		Else 
			$same_b:=True:C214
			
	End case 
	If (Not:C34($same_b))
		ALERT:C41("Parameter "+[Parameters:107]ParamCode:1+" different on "+$IPAddress_txt)
	End if 
	
	NEXT RECORD:C51([Parameters:107])
End while 

ut_SQLLogout
//_ o _USE INTERNAL DATABASE

//End ut_CompareParams