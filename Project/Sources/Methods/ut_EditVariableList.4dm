//%attributes = {"invisible":true}
// Method: ut_EditVariableList
// Description
//  ` Allow editing of process variables. They are passed in a form of a text string defined as :
//  ` {Varname1 ; Vartype1}  { Varname2 ; Vartype2} ...  {VarnameN ; VartypeN }
//  ` The type can be one of 
//  `  ` text , string , int , long, real, date
// Parameters
// $1 : $ParamList_txt
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/04/10, 10:54:57
	// ----------------------------------------------------
	
	Mods_2009_12
End if 
C_TEXT:C284($1; $ParamList_txt)
$ParamList_txt:=$1

C_BLOB:C604($Return_x)
$ParamList_txt:=Replace string:C233($ParamList_txt; "{"; "")
$Return_x:=ut_ParseTextToArrayDelim($ParamList_txt; "}")
ARRAY TEXT:C222($VarInfoList_atxt; 0)
BLOB TO VARIABLE:C533($Return_x; $VarInfoList_atxt)
C_LONGINT:C283($win)
C_LONGINT:C283($numVars_L; $loop_L)
$numVars_L:=0
ARRAY TEXT:C222(PVarNames_atxt; $numVars_L)
ARRAY TEXT:C222(PVarNamesTypes_atxt; $numVars_L)
ARRAY TEXT:C222(PVarInputs_atxt; $numVars_L)
ARRAY TEXT:C222(PVartypes_atxt; $numVars_L)
ARRAY TEXT:C222(PVarFormats_atxt; $numVars_L)
ARRAY TEXT:C222(PVarResults_atxt; $numVars_L)
ARRAY POINTER:C280(PVarPointers_aptr; $numVars_L)
$numVars_L:=Size of array:C274($VarInfoList_atxt)
ARRAY TEXT:C222(PVarNames_atxt; $numVars_L)
ARRAY TEXT:C222(PVartypes_atxt; $numVars_L)

C_LONGINT:C283($loop_L; $DelimPos)
C_TEXT:C284($varName_txt; $VarType_txt)
For ($loop_L; 1; $numVars_L)
	$DelimPos:=Position:C15(";"; $VarInfoList_atxt{$loop_L})
	If ($DelimPos>0)
		$varName_txt:=f_TrimStr(Substring:C12($VarInfoList_atxt{$loop_L}; 1; ($DelimPos-1)); True:C214; True:C214)
		$VarType_txt:=f_TrimStr(Substring:C12($VarInfoList_atxt{$loop_L}; ($DelimPos+1)); True:C214; True:C214)
		Case of 
			: ($varName_txt="")
			: ($VarType_txt="")
			Else 
				If (Find in array:C230(PVarNames_atxt; $varName_txt)>0)
				Else 
					PVarNames_atxt{$loop_L}:=$varName_txt
					PVartypes_atxt{$loop_L}:=$VarType_txt
				End if 
				
		End case 
		
	End if 
End for 
SORT ARRAY:C229(PVarNames_atxt; PVartypes_atxt)
While (PVarNames_atxt{1}="")
	DELETE FROM ARRAY:C228(PVarNames_atxt; 1)
	DELETE FROM ARRAY:C228(PVartypes_atxt; 1)
End while 
$numVars_L:=Size of array:C274(PVarNames_atxt)
ARRAY TEXT:C222(PVarNamesTypes_atxt; $numVars_L)
ARRAY TEXT:C222(PVarInputs_atxt; $numVars_L)
ARRAY TEXT:C222(PVarFormats_atxt; $numVars_L)
ARRAY TEXT:C222(PVarResults_atxt; $numVars_L)
ARRAY POINTER:C280(PVarPointers_aptr; $numVars_L)

C_TEXT:C284($compilerCmd_txt)
For ($loop_L; 1; Size of array:C274(PVarNames_atxt))
	$compilerCmd_txt:="C_TEXT("  //default is text
	
	Case of 
		: ((PVartypes_atxt{$loop_L}="Int@") | (PVartypes_atxt{$loop_L}="long@"))
			$compilerCmd_txt:="C_Longint("
		: (PVartypes_atxt{$loop_L}="real")
			$compilerCmd_txt:="C_REAL("
		: (PVartypes_atxt{$loop_L}="date")
			$compilerCmd_txt:="C_DATE("
	End case 
	EXECUTE FORMULA:C63($compilerCmd_txt+PVarNames_atxt{$loop_L}+")")
	PVarPointers_aptr{$loop_L}:=Get pointer:C304(PVarNames_atxt{$loop_L})
	PVarNamesTypes_atxt{$loop_L}:=PVarNames_atxt{$loop_L}+" ["+Uppercase:C13(PVartypes_atxt{$loop_L})+"]"
	Case of 
		: ((PVartypes_atxt{$loop_L}="text") | (PVartypes_atxt{$loop_L}="string"))
			PVarResults_atxt{$loop_L}:=PVarPointers_aptr{$loop_L}->
			PVarResults_atxt{$loop_L}:=Replace string:C233(PVarResults_atxt{$loop_L}; Char:C90(13); "\\r")
		: ((PVartypes_atxt{$loop_L}="Int@") | (PVartypes_atxt{$loop_L}="long@"))
			PVarResults_atxt{$loop_L}:=String:C10(PVarPointers_aptr{$loop_L}->)
		: (PVartypes_atxt{$loop_L}="real")
			PVarResults_atxt{$loop_L}:=String:C10(PVarPointers_aptr{$loop_L}->)
		: (PVartypes_atxt{$loop_L}="date")
			PVarResults_atxt{$loop_L}:=String:C10(PVarPointers_aptr{$loop_L}->; Internal date short:K1:7)
	End case 
	PVarInputs_atxt{$loop_L}:=PVarResults_atxt{$loop_L}
End for 

$win:=Open form window:C675([zDialogs:68]; "EditListBox")

SET WINDOW TITLE:C213("Custom Variable Editor")
DIALOG:C40([zDialogs:68]; "EditListBox")
CLOSE WINDOW:C154
If (OK=1)
	
	For ($loop_L; 1; Size of array:C274(PVarNames_atxt))
		Case of 
			: ((PVartypes_atxt{$loop_L}="text") | (PVartypes_atxt{$loop_L}="string"))
				PVarPointers_aptr{$loop_L}->:=PVarInputs_atxt{$loop_L}
				PVarPointers_aptr{$loop_L}->:=Replace string:C233(PVarPointers_aptr{$loop_L}->; "\\r"; Char:C90(13))
			: ((PVartypes_atxt{$loop_L}="Int@") | (PVartypes_atxt{$loop_L}="long@"))
				PVarPointers_aptr{$loop_L}->:=Num:C11(PVarInputs_atxt{$loop_L})
			: (PVartypes_atxt{$loop_L}="real")
				PVarPointers_aptr{$loop_L}->:=Num:C11(PVarInputs_atxt{$loop_L})
			: (PVartypes_atxt{$loop_L}="date")
				PVarPointers_aptr{$loop_L}->:=Date:C102(PVarInputs_atxt{$loop_L})
		End case 
	End for 
	
End if 