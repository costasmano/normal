//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 02/23/17, 15:59:38
//----------------------------------------------------
//Method: sql_FillLimitArrays
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2020_01  //Thids method should no longer be used. Instead always use clone_CreateSQLLimits
End if 
TRACE:C157

ARRAY TEXT:C222(SQL_LimitNames_atxt; 0)
ARRAY LONGINT:C221(SQL_Limits_AL; 0)

C_TEXT:C284($Query_txt)
$Query_txt:="SQL_LIMITS"
Repeat 
	Begin SQL
		
		SELECT [TableOfLists].[ListValue_s], [TableOfLists].[ListSequence_l] 
		FROM [TableOfLists] 
		WHERE [TableOfLists].[ListName_s] = :$Query_txt 
		ORDER BY [TableOfLists].ListSequence_l ASC, [TableOfLists].ListValue_s ASC 
		INTO :SQL_LimitNames_atxt, :SQL_Limits_AL;
		
	End SQL
	
	clone_CreateSQLLimits
	
	
Until (Size of array:C274(SQL_LimitNames_atxt)>0)


//End sql_FillLimitArrays

