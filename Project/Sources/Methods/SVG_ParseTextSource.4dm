//%attributes = {"invisible":true}
//Method: SVG_ParseTextSource
//Description
// Parse the variable paased in pointer 1 and return the svg ref in pointer 2
// Parameters
// $0 : $Success_B
// $1 : $XMLsource_ptr
// $2 : $svgref_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/01/15, 17:32:12
	// ----------------------------------------------------
	//Created : 
	Mods_2015_09
	
	C_BOOLEAN:C305(SVG_ParseTextSource; $0)
	C_POINTER:C301(SVG_ParseTextSource; $1)
	C_POINTER:C301(SVG_ParseTextSource; $2)
End if 
//
C_BOOLEAN:C305($0)
C_POINTER:C301($1; $2)
$0:=False:C215

C_TEXT:C284($svgref)
gError:=0
ON ERR CALL:C155("Error Handler")
$svgref:=DOM Parse XML variable:C720($1->)
ON ERR CALL:C155("")
If (gError=0)
	$0:=True:C214
	$2->:=$svgref
Else 
	$2->:=""
End if 

//End SVG_ParseTextSource