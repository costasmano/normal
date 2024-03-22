//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/29/10, 14:22:10
	// ----------------------------------------------------
	// Method: f_Insp_Revision6
	// Description
	// Verify revision 6 of inspection forms
	//  ` It is the addition of the shielding Element 114  under the Deck category.
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_01
End if 
C_BOOLEAN:C305($0)
C_DATE:C307($1; $vDateCheck; <>InspFormRevDate_6)
$vDateCheck:=$1
If (<>InspFormRevDate_6#!00-00-00!)
	$0:=($vDateCheck>=<>InspFormRevDate_6)
Else 
	$0:=False:C215
End if 