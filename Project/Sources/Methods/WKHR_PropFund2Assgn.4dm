//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/26/07, 12:37:47
	// ----------------------------------------------------
	// Method: WKHR_PropFund2Assgn
	// Description
	// Handle transfer of funds from proposal to assignement
	// 
	// Parameters
	// $1 :  $Option_txt : (Update or Clear)
	// ----------------------------------------------------
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(4/22/09 12:44:20)
	Mods_2009_04
	//  `Added @ after "External" for the .4DC extension used in 4D 2004 version
End if 
C_TEXT:C284($1; $Option_txt)
$Option_txt:=$1
C_TEXT:C284($msg)
If (Structure file:C489="@External@")
	C_BOOLEAN:C305($Success_b)
	$Success_b:=WKHR_ProposalToAssignRemote($Option_txt)
	If ($Success_b)
		$msg:="Assignment Data updated on Boston server successfully!"
	Else 
		$msg:="Errors/Problems during update of Assignment Data! Update has to be done manually!"
	End if 
	ALERT:C41($msg)
Else 
	WKHR_SaveRelated_B:=(False:C215 | WKHR_SaveRelated_B)  //just in case something was saved before
	WKHR_ProposalToAssgn($Option_txt)
	
End if 