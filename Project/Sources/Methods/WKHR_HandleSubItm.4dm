//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/01/05, 21:22:46
	// ----------------------------------------------------
	// Method: WKHR_HandleSubItm
	// Description
	// handle entry in sub item values
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM21
	// Modified by: costasmanousakis-(Designer)-(6/19/08 11:05:07)
	Mods_2008_CM_5403  // ("WKHRS")
	// Modified by: costasmanousakis-(Designer)-(2/10/09 22:27:24)
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 11:57:25  ` ("WKHRMODS")
End if 
C_POINTER:C301($1; $MyValue)
$MyValue:=$1
C_LONGINT:C283($Tbl; $Fld)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($VarName; $VarType; $VarPrefix; $SumVarPref)  // Command Replaced was o_C_STRING length was 32
RESOLVE POINTER:C394($Myvalue; $VarName; $Tbl; $Fld)
C_POINTER:C301($ptr_value; $ptr_sum)
C_LONGINT:C283($i; $j)  //Command Replaced was o_C_INTEGER
$VarType:=Substring:C12($VarName; 1; Position:C15("_"; $VarName))
$VarPrefix:=Substring:C12($VarType; 1; (Length:C16($VarType)-2))
$VarPrefix:=Replace string:C233($VarPrefix; "SubItmV"; "")
If ($VarPrefix="")
	$SumVarPref:="WKHR_Real_"
Else 
	$SumVarPref:="OfficeEstItm_"
End if 

$ptr_sum:=Get pointer:C304($VarType+"6")
$ptr_sum->:=0
For ($i; 1; WKHR_CategoryCount_i)
	$ptr_value:=Get pointer:C304($VarType+String:C10(WKHR_CatIndx_aL{$i}))
	$ptr_sum->:=($ptr_sum->)+($ptr_value->)
End for 
For ($i; 1; (WKHR_CategoryCount_i+1))
	$ptr_sum:=Get pointer:C304($SumVarPref+String:C10($i))
	$ptr_sum->:=0
	For ($j; 1; WKHR_MaxNumSubBreakDwn)
		$ptr_value:=Get pointer:C304($VarPrefix+"SubItmV"+String:C10($j)+"_"+String:C10($i))
		$ptr_sum->:=($ptr_sum->)+($ptr_value->)
	End for 
	
End for 