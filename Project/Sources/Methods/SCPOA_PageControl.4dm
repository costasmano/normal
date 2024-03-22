//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/15/09, 19:12:51
	// ----------------------------------------------------
	// Method: SCPOA_PageControl
	// Description
	// 
	// 
	// Parameters
	// $1 : Direction "NEXT" | "PREVIOUS"
	// ----------------------------------------------------
	
	Mods_2009_12
End if 
C_TEXT:C284($1)
C_LONGINT:C283($currPart_L)
$currPart_L:=SectionSCPOASelect_atxt

Case of 
	: ($1="NEXT")
		If ($currPart_L=Size of array:C274(SectionSCPOASelect_atxt))
			$currPart_L:=1
		Else 
			$currPart_L:=$currPart_L+1
		End if 
		
	: ($1="PREVIOUS")
		If ($currPart_L=1)
			$currPart_L:=Size of array:C274(SectionSCPOASelect_atxt)
		Else 
			$currPart_L:=$currPart_L-1
		End if 
		
End case 
SectionSCPOASelect_atxt:=$currPart_L
FORM GOTO PAGE:C247(SCPOA_SectionPage_aL{$currPart_L})