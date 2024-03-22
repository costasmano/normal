//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/19/10, 14:24:46
	// ----------------------------------------------------
	// Method: Method: fn_NewDistrictNo
	// Description
	// return the new district num for a BDEPT
	// 
	// Parameters
	// $0 : $DistrNo_s (A2) : the new item 2
	// $1 : $BIN_txt (Optional) - otherwise use the current [Bridge mhd nbis] record
	// ----------------------------------------------------
	
	Mods_2010_02
End if 
C_TEXT:C284($0; $DistrNo_s)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284($BIN_txt; $BINTown_txt)
$BINTown_txt:=""
$DistrNo_s:=""
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$BIN_txt:=$1
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$BIN_txt)
	$BINTown_txt:=[Bridge MHD NBIS:1]Town Name:175
	$DistrNo_s:=[Bridge MHD NBIS:1]Item2:60
Else 
	$BINTown_txt:=[Bridge MHD NBIS:1]Town Name:175
	$DistrNo_s:=[Bridge MHD NBIS:1]Item2:60
End if 

If (Find in array:C230(<>D6Towns_atxt; $BINTown_txt)>0)
	$DistrNo_s:="06"
End if 

$0:=$DistrNo_s