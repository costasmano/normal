//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/15/10, 10:42:30
	// ----------------------------------------------------
	// Method: DCM_WO_DistrAreaCtrl
	// Description
	//  `Control the initializing of the DCM_DistrAreas_as pulldown
	// 
	// Parameters
	// $1 : $Task
	// ----------------------------------------------------
	
	Mods_2010_11
	Mods_2011_06  // CJ Miller`06/20/11, 10:23:19      ` Type all local variables for v11
End if 
C_TEXT:C284($Task)
$Task:="LOAD"
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$Task:=$1
End if 
If ($Task="")
	$Task:="LOAD"
End if 
Case of 
	: ($Task="LOAD")
		C_LONGINT:C283($District)
		ARRAY TEXT:C222(DCM_DistrAreas_as; 0)  //Command Replaced was o_ARRAY string length was 1
		$District:=3
		Case of 
			: ($District=3)
				ARRAY TEXT:C222(DCM_DistrAreas_as; 4)  //Command Replaced was o_ARRAY string length was 1
				DCM_DistrAreas_as{1}:=""
				DCM_DistrAreas_as{2}:="A"
				DCM_DistrAreas_as{3}:="B"
				DCM_DistrAreas_as{4}:="C"
				
		End case 
		
End case 