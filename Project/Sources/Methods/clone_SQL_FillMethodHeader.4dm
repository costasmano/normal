//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/02/14, 13:46:06
//----------------------------------------------------
//Method: clone_SQL_FillMethodHeader
//Description
//This method fills header of Compiler, clear and clone methods created for you
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
C_POINTER:C301($1; $2; $3; $4)
C_LONGINT:C283($5)
C_LONGINT:C283($Loop_l; $TableLoop_l)

$TableLoop_l:=$5
C_TEXT:C284($TableName_txt)
$TableName_txt:=Table name:C256($TableLoop_l)



C_TEXT:C284($CompilerDocument_txt; $ArraytoSelectionsDoc_txt; $ClearDocument_txt; $CaseArrayLine_txt)  //matches in order of pointers


$CompilerDocument_txt:=$CompilerDocument_txt+"// ----------------------------------------------------"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"// User name (OS): Charles Miller"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"// Date and time: 05/06/10, 11:58:58"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"// ----------------------------------------------------"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"// Method: Compiler_FieldVariables"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"// Description"+Char:C90(Carriage return:K15:38)

$ArraytoSelectionsDoc_txt:=$CompilerDocument_txt
$ArraytoSelectionsDoc_txt:=Replace string:C233($ArraytoSelectionsDoc_txt; "Compiler_FieldVariables"; "Clone_ArrayToSelection")
$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+"//This method is used to do array to selection during clone of tables"+Char:C90(Carriage return:K15:38)
$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+"If(false)"+Char:C90(Carriage return:K15:38)+" // recreated on "+String:C10(Current date:C33; 7)+Char:C90(Carriage return:K15:38)+"end if"+Char:C90(Carriage return:K15:38)
$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+"C_LONGINT($1)"+Char:C90(Carriage return:K15:38)+"C_Pointer($Array_Ptr)"+Char:C90(Carriage return:K15:38)+"Case of"+Char:C90(Carriage return:K15:38)

$CompilerDocument_txt:=$CompilerDocument_txt+"//This method is used to define variables in a non compiled db"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"//It should be recreated any time a new table or field is added or a type is changed"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"//Remember to keep the following as a wrapper"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"//If (Not(Is compiled mode))"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"//If (Count parameters=0)"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"//C_LONGINT($Loop_l)"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"//For ($Loop_l;1;Get last table number)"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"//If (Is table number valid($Loop_l))"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"//Compiler_FieldVariables ($Loop_l)"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"//end if"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"//End for "+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"//"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"//Else "+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"//C_LONGINT($1)"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"//End if "+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+" "+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"// Parameters"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"// ----------------------------------------------------"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"//$1 table number"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+" "+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"// Modified by: Charles Miller (5/6/10)"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+" If (False)"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"//Modified by: Charles Miller (8/11/10 11:06:44) "+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+" // Updated by clone_NewCreateSQLVariables on "+String:C10(Current date:C33)+" - "+String:C10(Current time:C178)+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+" End if "+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+" // "+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"If (Count parameters=0)"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"C_LONGINT($Loop_l)"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"For ($Loop_l;1;Get last table number)"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"If (Is table number valid($Loop_l))"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"Compiler_FieldVariables ($Loop_l)"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"End if "+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"End for "+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"Else "+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"C_LONGINT($1)"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+"CASE OF"+Char:C90(Carriage return:K15:38)+":($1="+String:C10($TableLoop_l)+")//"+$TableName_txt+Char:C90(Carriage return:K15:38)

$ClearDocument_txt:=$ClearDocument_txt+"// ----------------------------------------------------"+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"// User name (OS): Charles Miller"+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"// Date and time: 05/06/10, 11:56:42"+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"// ----------------------------------------------------"+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"// Method: clone_ClearFieldVariables"+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"// Description"+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"// This method is used to clear variable for sql updates"+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"//It should be recreated any time a new table or field is added or a type is changed"+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"//"+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"// Parameters"+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"// ----------------------------------------------------"+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"//$1 is the table number"+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+""+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"// Modified by: Charles Miller (5/6/10)"+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"If (False)"+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"//Modified by: Charles Miller (8/11/10 11:34:45) "+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"// Updated by clone_NewCreateSQLVariables on "+String:C10(Current date:C33)+" - "+String:C10(Current time:C178)+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"End if "+Char:C90(Carriage return:K15:38)

$ClearDocument_txt:=$ClearDocument_txt+" // "+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"If (Count parameters=0)"+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"C_LONGINT($Loop_l)"+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"For ($Loop_l;1;Get last table number)"+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"If (Is table number valid($Loop_l))"+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"clone_ClearFieldVariables ($Loop_l)"+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"End if "+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"End for "+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"Else"+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"C_LONGINT($1)"+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+"CASE OF"+Char:C90(Carriage return:K15:38)+":($1="+String:C10($TableLoop_l)+")//"+$TableName_txt+Char:C90(Carriage return:K15:38)
$CaseArrayLine_txt:=":($1="+String:C10($TableLoop_l)+")//"+$TableName_txt+Char:C90(Carriage return:K15:38)


$1->:=$CompilerDocument_txt
$2->:=$ArraytoSelectionsDoc_txt
$3->:=$ClearDocument_txt
$4->:=$CaseArrayLine_txt
//End clone_SQL_FillMethodHeader