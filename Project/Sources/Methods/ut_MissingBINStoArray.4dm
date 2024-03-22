//%attributes = {"invisible":true}
//Method: ut_MissingBINStoArray
//Description
//  ` Find Missing BINS and load them into an array
// Parameters
// $1 : $BinArray_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/25/12, 08:56:49
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
	// Modified by: Costas Manousakis-(Designer)-(12/12/16 17:21:24)
	Mods_2016_12
	//  `SET QUERY DESTINATION(Into current selection ) WAS MISSING!!!!
	// Modified by: Costas Manousakis-(Designer)-(2023-07-05 18:02:22)
	Mods_2023_07
	//  `use selection to array to check against existing BINS.
End if 
//
C_POINTER:C301($1; $BinArray_ptr)

$BinArray_ptr:=$1

READ ONLY:C145([Sequences:28])
READ ONLY:C145([Bridge MHD NBIS:1])

QUERY:C277([Sequences:28]; [Sequences:28]Name:1="BIN")
C_LONGINT:C283($LastBINSeq_L; $foundBIN_L; $loop_L; $BinCount_L; $startArrCount_L)
$LastBINSeq_L:=[Sequences:28]Value:2
C_TEXT:C284($tempBin_txt)

//First clear the array
$startArrCount_L:=Size of array:C274($BinArray_ptr->)
If ($startArrCount_L>0)
	DELETE FROM ARRAY:C228($BinArray_ptr->; 1; $startArrCount_L)
End if 

ARRAY TEXT:C222($Bins_atxt; 0)
ALL RECORDS:C47([Bridge MHD NBIS:1])
ORDER BY:C49([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3)
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $Bins_atxt)

For ($loop_L; 1; $LastBINSeq_L)
	$tempBin_txt:=ConvertBIN($loop_L)
	If (Find in array:C230($Bins_atxt; $tempBin_txt)<1)
		APPEND TO ARRAY:C911($BinArray_ptr->; $tempBin_txt)
	End if 
	
End for 

//End ut_MissingBINStoArray