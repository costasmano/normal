//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/11/07, 12:43:21
	// ----------------------------------------------------
	// Method: f_Insp_Revision3
	// Description
	// 
	// 
	// Parameters
	//$0 : True/ False  
	//$1 : Date
	// ----------------------------------------------------
	MODS_2007_CM04
End if 

C_BOOLEAN:C305($0)
C_DATE:C307($1; $vDateCheck)
$vDateCheck:=$1
$0:=($vDateCheck>=<>InspFormRevDate_3)