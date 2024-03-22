//%attributes = {"invisible":true}
//Method: SVG_FindSetTspan
//Description
// set the text of a Tspan element in an element based on ID 
// Parameters
// $0 : $success_b
// $1 : $svgRef
// $2 : $ID_txt
// $3 :  $IDValue_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/31/15, 16:41:01
	// ----------------------------------------------------
	//Created : 
	Mods_2015_09
	
	C_BOOLEAN:C305(SVG_FindSetTspan; $0)
	C_TEXT:C284(SVG_FindSetTspan; $1)
	C_TEXT:C284(SVG_FindSetTspan; $2)
	C_TEXT:C284(SVG_FindSetTspan; $3)
	
	// Modified by: Costas Manousakis-(Designer)-(9/14/16 17:06:05)
	Mods_2016_09
	//  //Re-enabled all SVG plugin calls - were disabled in v11
End if 
//
C_BOOLEAN:C305($0)

C_TEXT:C284($1; $2; $3)
C_TEXT:C284($svgRef; $ID_txt; $IDValue_txt)

$ID_txt:=$2
$0:=False:C215

// *** SVG OUT *** 
$hsref:=SVG_Find_ID($1; $ID_txt)
C_LONGINT:C283($count)
C_TEXT:C284($hsref; $tRef; $value_txt)
//C_BLOB($blob_blb)
If ($hsref#"")
	//$count:=DOM Count XML elements($hsref;"tspan")
	$tRef:=DOM Find XML element:C864($hsref; "text/tspan")
	//DOM GET XML ELEMENT VALUE($tRef;$value_txt;$blob_blb)
	DOM SET XML ELEMENT VALUE:C868($tRef; $3)
	$0:=True:C214
End if 
//End SVG_FindSetTspan