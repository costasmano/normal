//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/10/08, 10:10:39
	// ----------------------------------------------------
	// Method: SC_ParseTBLLine
	// Description
	// Parse a line representing a table line in table 71_26
	// 
	// Parameters
	// $1 : $Start_txt
	// ----------------------------------------------------
	
	Mods_2008_CM_5403("SCOUR")
End if 
C_TEXT:C284($1; $Start_txt; $part1_txt; $part2_txt)
$Start_txt:=$1
$Start_txt:=Replace string:C233($Start_txt; " "; "")
C_LONGINT:C283($semi_L; $Brack1_L; $Brack2_L; $Brack3_L)
ARRAY TEXT:C222(sc_TempIndx_atxt; 0)
ARRAY TEXT:C222(sc_TempVal_atxt; 0)
While ($Start_txt#"")
	$semi_L:=Position:C15(";"; $Start_txt)
	If ($semi_L>0)
		$part1_txt:=Substring:C12($Start_txt; 1; ($semi_L-1))
		$Start_txt:=Substring:C12($Start_txt; ($semi_L+1))
	Else 
		$part1_txt:=$Start_txt
		$Start_txt:=""
	End if 
	$Brack1_L:=Position:C15("["; $part1_txt)
	If ($Brack1_L>0)
		$Brack2_L:=Position:C15("]["; $part1_txt)
		If ($Brack2_L>0)
			$part2_txt:=Substring:C12($part1_txt; ($Brack2_L+2))
			$Brack3_L:=Position:C15("]"; $part2_txt)
			If ($Brack3_L>0)
				INSERT IN ARRAY:C227(sc_TempIndx_atxt; (Size of array:C274(sc_TempIndx_atxt)+1))
				INSERT IN ARRAY:C227(sc_TempVal_atxt; (Size of array:C274(sc_TempIndx_atxt)+1))
				sc_TempIndx_atxt{Size of array:C274(sc_TempIndx_atxt)}:=Substring:C12($part1_txt; ($Brack1_L+1); ($Brack2_L-$Brack1_L-1))
				sc_TempVal_atxt{Size of array:C274(sc_TempIndx_atxt)}:=Substring:C12($part2_txt; 1; ($Brack3_L-1))
			End if 
		End if 
	End if 
End while 