//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/22/07, 22:53:10
	// ----------------------------------------------------
	// Method: f_Insp_Revision5
	// Description
	// Verify revision 5 of inspection forms
	// 
	// Parameters
	// $1 : $vDateCheck (date)
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
End if 

C_BOOLEAN:C305($0)
C_DATE:C307($1; $vDateCheck; <>InspFormRevDate_5)
$vDateCheck:=$1
If (<>InspFormRevDate_5#!00-00-00!)
	$0:=($vDateCheck>=<>InspFormRevDate_5)
Else 
	$0:=False:C215
End if 