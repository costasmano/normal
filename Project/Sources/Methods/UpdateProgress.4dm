//%attributes = {"invisible":true}
If (False:C215)
	// Procedure: UpdateProgress (Current position; Total records)
	// $1   Longint   selected record number
	// $2   Longint   records in selection
	//
	// This procedure sets the dialog variables - thermometer and.
	// text, and updates their display. Updating is controlled by use
	// of a designer-specified modulus test.
	
	// Preconditions : None
	
	// Assumptions : None
	//
	// Created 4/30/94 —Forrest Swilling
End if 

C_LONGINT:C283($1; $2; $Current; $Total)
$Current:=$1
$Total:=$2
//If ($Current%5=0)  ` only update every fifth record controlled by caller
<>Progress:=$Current/$Total*100  // calculate percentage
C_LONGINT:C283($vlElapsedMS; $vlRemainHrs; $vlRemainMin; $vlRemainSec)
C_REAL:C285($vlRemainMS)
If (<>Progress>0.5)
	$vlElapsedMS:=Milliseconds:C459-<>vtProgressSt_ms
	$vlRemainMS:=($vlElapsedMS*(($Total-$Current)/$Current))/1000
	$vlRemainHrs:=Int:C8(($vlRemainMS)/(60*60))
	$vlRemainMin:=Int:C8(($vlRemainMS-(60*60*$vlRemainHrs))/60)
	$vlRemainSec:=Int:C8(($vlRemainMS-(60*60*$vlRemainHrs)-(60*$vlRemainMin)))
	C_TEXT:C284($vsTimeLeft)  // Command Replaced was o_C_STRING length was 120
	$vsTimeLeft:=""
	$vsTimeLeft:=String:C10($vlRemainHrs; "###0h ;;")+String:C10($vlRemainMin; "#0m ;;")+String:C10($vlRemainSec; "#0s;;")
	<>TimeRemaining:="Estimated Time Left : "+$vsTimeLeft
End if 
<>Remaining:=$Total-$Current  // calculate remaining records
POST OUTSIDE CALL:C329(-1)  // update display
//End if 