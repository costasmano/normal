//%attributes = {"invisible":true}
//Method: ut_CountFormVars
//Description
// Count form variables on a form
// Parameters
// $0 : $Count_L
// $1 : $Varpattern_txt (optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/17/16, 09:49:46
	// ----------------------------------------------------
	//Created : 
	Mods_2016_05_bug
	
	C_LONGINT:C283(ut_CountFormVars; $0)
	C_TEXT:C284(ut_CountFormVars; $1)
End if 
//

C_LONGINT:C283($0)
C_LONGINT:C283($Count_L)
C_TEXT:C284($pattern_txt)
$pattern_txt:=""
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$pattern_txt:=$1
End if 
$Count_L:=0

ARRAY TEXT:C222($objects_atxt; 0)
ARRAY POINTER:C280($vars_aptr; 0)
FORM GET OBJECTS:C898($objects_atxt; $vars_aptr)
C_LONGINT:C283($tbl_L; $fld_L)
C_TEXT:C284($VarName_txt)
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($vars_aptr))
	RESOLVE POINTER:C394($vars_aptr{$loop_L}; $VarName_txt; $tbl_L; $fld_L)
	
	If ($pattern_txt#"")
		If ($VarName_txt=$pattern_txt)
			$count_L:=$count_L+1
		End if 
		
	Else 
		If ($VarName_txt#"")
			$count_L:=$count_L+1
		End if 
	End if 
	
End for 

$0:=$Count_L
//End ut_CountFormVars